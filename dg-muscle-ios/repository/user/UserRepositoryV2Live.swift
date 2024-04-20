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
    }
}
