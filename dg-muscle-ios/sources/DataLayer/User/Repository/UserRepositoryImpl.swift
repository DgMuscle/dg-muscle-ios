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
        try await AuthManager().updateUser(displayName: displayName, photoURL: photoURL)
    }
    
    public func withDrawal() async -> (any Error)? {
        await AuthManager().withDrawal()
    }
    
    private func bind() {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                return
            }
            self._user = .init(uid: user.uid, displayName: user.displayName, photoURL: user.photoURL)
        }
        
        $_user
            .sink { user in
                self.isLogin = user != nil
            }
            .store(in: &cancellables)
    }
}
