//
//  UserRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine
import FirebaseAuth

final class UserRepositoryData: UserRepository {
    static let shared = UserRepositoryData()
    
    var user: UserDomain? { _user }
    var userPublisher: AnyPublisher<UserDomain?, Never> { $_user.eraseToAnyPublisher() }
    @Published private var _user: UserDomain?
    
    var isLogin: Bool { _isLogin }
    var isLoginPublisher: AnyPublisher<Bool, Never> { $_isLogin.eraseToAnyPublisher() }
    @Published private var _isLogin: Bool = true
    
    var users: [UserDomain] { _users }
    var usersPublisher: AnyPublisher<[UserDomain], Never> { $_users.eraseToAnyPublisher() }
    @Published private var _users: [UserDomain] = []
    
    @Published private var _fcmtoken: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private init() {
        bind()
        Task {
            _users = try await getUsersFromServer()
        }
    }
    
    func set(fcmtoken: String) {
        self._fcmtoken = fcmtoken
    }
    
    func signOut() throws {
        try Authenticator().signOut()
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        _user?.displayName = displayName
        _user?.photoURL = photoURL
        try await Authenticator().updateUser(displayName: displayName, photoURL: photoURL)
    }
    
    func updateUser(displayName: String?) async throws {
        _user?.displayName = displayName
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        try await changeRequest?.commitChanges()
    }
    
    func updateUser(photoURL: URL?) async throws {
        _user?.photoURL = photoURL
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        try await changeRequest?.commitChanges()
    }
    
    func withDrawal() async -> (any Error)? {
        await Authenticator().withDrawal()
    }
    
    func get(id: String) async throws -> UserDomain {
        if let user = self.users.first(where: { $0.uid == id }) {
            return user
        } else {
            let data: UserData = try await APIClient.shared.request(url: FunctionsURL.user(.getprofilefromuid) + "?uid=\(id)")
            return data.domain
        }
    }
    
    private func postProfile(id: String, displayName: String?, photoURL: String?, fcmtoken: String?, heatmapColor: HeatmapColorDomain) async throws {
        let url = FunctionsURL.user(.postprofile)
        struct Body: Codable {
            let id: String
            let displayName: String
            let photoURL: String?
            let fcmtoken: String?
            let heatmapColor: String
        }
        
        let heatmapColor: HeatmapColorData = .init(color: heatmapColor)
        
        
        let body: Body = .init(id: id, displayName: displayName ?? "", photoURL: photoURL, fcmtoken: fcmtoken, heatmapColor: heatmapColor.rawValue)
        let _: ResponseData = try await APIClient.shared.request(method: .post, url: url, body: body)
    }
    
    private func bind() {
        $_user.compactMap({ $0 })
            .combineLatest($_fcmtoken, HeatmapRepositoryData.shared.heatmapColorPublisher)
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { user, token, heatmapColor in
                Task {
                    try await self.postProfile(id: user.uid,
                                               displayName: user.displayName,
                                               photoURL: user.photoURL?.absoluteString,
                                               fcmtoken: token, 
                                               heatmapColor: heatmapColor)
                }
            }
            .store(in: &cancellables)
        
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                self._isLogin = false
                try? FileManagerHelperV2.shared.deleteAll()
                return
            }
            self._user = .init(uid: user.uid, 
                               displayName: user.displayName,
                               photoURL: user.photoURL,
                               heatmapColor: .green)
            self._isLogin = true
        }
    }
    
    private func getUsersFromServer() async throws -> [UserDomain] {
        let data: [UserData] = try await APIClient.shared.request(method: .get, url: FunctionsURL.user(.getprofiles))
        let users: [UserDomain] = data.map({ $0.domain })
        return users
    }
}
