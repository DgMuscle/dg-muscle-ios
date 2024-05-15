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
    @Published var _user: Domain.User? = nil
    
    private init() {
        bind()
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
