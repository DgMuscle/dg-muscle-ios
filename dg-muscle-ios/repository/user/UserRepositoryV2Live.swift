//
//  UserRepositoryV2Live.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Foundation
import Combine
import FirebaseAuth

final class UserRepositoryV2Live: UserRepositoryV2 {
    static let shared = UserRepositoryV2Live()
    
    var user: DGUser? {
        _user
    }
    
    var userPublisher: AnyPublisher<DGUser?, Never> {
        $_user.eraseToAnyPublisher()
    }
    
    var isLogin: Bool { _isLogin }
    var isLoginPublisher: AnyPublisher<Bool, Never> {
        $_isLogin.eraseToAnyPublisher()
    }
    
    @Published private var _user: DGUser?
    @Published private var _isLogin: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        bind()
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
    
    func withDrawal() async -> Error? {
        await Authenticator().withDrawal()
    }
    
    private func bind() {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                self._isLogin = false
                return
            }
            self._user = .init(uid: user.uid, displayName: user.displayName, photoURL: user.photoURL)
            self._isLogin = true
            
            
        }
        
        $_user
            .compactMap({ $0 })
            .sink { user in
                Task {
                    let _ = try await self.postProfile(id: user.uid, displayName: user.displayName, photoURL: user.photoURL?.absoluteString)
                }
            }
            .store(in: &cancellables)
    }
    
    private func postProfile(id: String, displayName: String?, photoURL: String?) async throws -> DefaultResponse {
        let url = "https://us-central1-dg-muscle.cloudfunctions.net/v3user-postprofile"
        
        struct Body: Codable {
            let id: String
            let displayName: String
            let photoURL: String?
        }
        
        let body: Body = .init(id: id, displayName: displayName ?? "", photoURL: photoURL)
        
        return try await APIClient.shared.requestV2(method: .post, url: url, body: body)
    }
}
