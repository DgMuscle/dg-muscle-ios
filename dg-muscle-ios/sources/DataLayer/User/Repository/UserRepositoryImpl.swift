//
//  UserRepositoryImpl.swift
//  Data
//
//  Created by Donggyu Shin on 5/14/24.
//

import Combine
import Domain
import Foundation
import FirebaseAuth

public final class UserRepositoryImpl: UserRepository {
    public static let shared = UserRepositoryImpl()
    public var user: AnyPublisher<Domain.User?, Never> { $_user.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()
    
    @Published var _user: Domain.User? = nil
    @Published var isLogin: Bool = false
    
    private init() {
        bind()
    }
    
    public func signOut() throws {
        try AuthManager().signOut()
    }
    
    public func updateUser(displayName: String?, photoURL: URL?) async throws {
        _user?.displayName = displayName
        _user?.photoURL = photoURL
        try await AuthManager().updateUser(displayName: displayName, photoURL: photoURL)
    }
    
    public func updateUser(displayName: String?) async throws {
        _user?.displayName = displayName
        try await AuthManager().updateUser(displayName: displayName)
    }
    
    public func updateUser(photoURL: URL?) async throws {
        _user?.photoURL = photoURL
        try await AuthManager().updateUser(photoURL: photoURL)
    }
    
    public func withDrawal() async -> (any Error)? {
        await AuthManager().withDrawal()
    }
    
    public func get() -> Domain.User? {
        _user
    }
    
    public func post(_ heatMapColor: Domain.HeatMapColor) throws {
        _user?.heatMapColor = heatMapColor
        let heatMapColor: HeatMapColor = .init(domain: heatMapColor)
        try FileManagerHelper.shared.save(heatMapColor, toFile: .heatmapColor)
    }
    
    private func get() throws -> Domain.HeatMapColor {
        let data = try FileManagerHelper.shared.load(HeatMapColor.self, fromFile: .heatmapColor)
        return data.domain
    }
    
    public func post(fcmToken: String) {
        _user?.fcmToken = fcmToken
    }
    
    private func bind() {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                return
            }
            
            let heatMapColor: Domain.HeatMapColor? = try? self.get()
            
            self._user = .init(
                uid: user.uid,
                displayName: user.displayName,
                photoURL: user.photoURL,
                heatMapColor: heatMapColor ?? .green, 
                fcmToken: nil
            )
        }
        
        $_user
            .sink { user in
                self.isLogin = user != nil
                Task {
                    if let user {
                        try await self.postUserProfileToServer(user: user)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func postUserProfileToServer(user: Domain.User) async throws {
        let url = FunctionsURL.user(.postprofile)
        
        struct Body: Codable {
            let id: String
            let displayName: String
            let photoURL: String?
            let fcmtoken: String?
            let heatmapColor: String
        }
        
        let user: UserData = .init(domain: user)
        
        let body: Body = .init(
            id: user.uid,
            displayName: user.displayName ?? "",
            photoURL: user.photoURL,
            fcmtoken: user.fcmToken,
            heatmapColor: user.heatMapColor?.rawValue ?? "green"
        )
        
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: body
        )
    }
}
