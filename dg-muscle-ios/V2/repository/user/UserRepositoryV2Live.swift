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
    
    var isLogin: Bool {
        return user != nil
    }
    
    @Published private var _user: DGUser?
    
    private init() {
        bind()
    }
    
    func signOut() throws {
        try Authenticator().signOut()
    }
    
    func updateUser(displayName: String?, photoURL: URL?) async throws {
        try await Authenticator().updateUser(displayName: displayName, photoURL: photoURL)
    }
    
    func withDrawal() async -> Error? {
        await Authenticator().withDrawal()
    }
    
    private func bind() {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                return
            }
            self._user = .init(uid: user.uid, displayName: user.displayName, photoURL: user.photoURL)
        }
    }
}
