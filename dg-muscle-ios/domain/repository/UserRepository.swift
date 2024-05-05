//
//  UserRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

protocol UserRepository {
    var user: UserDomain? { get }
    var userPublisher: AnyPublisher<UserDomain?, Never> { get }
    var isLogin: Bool { get }
    var isLoginPublisher: AnyPublisher<Bool, Never> { get }
    var users: [UserDomain] { get }
    var usersPublisher: AnyPublisher<[UserDomain], Never> { get }
    
    func signOut() throws
    func updateUser(displayName: String?, photoURL: URL?) async throws
    func updateUser(displayName: String?) async throws
    func updateUser(photoURL: URL?) async throws
    func withDrawal() async -> Error?
    func set(fcmtoken: String)
    func get(id: String) async throws -> UserDomain
}
