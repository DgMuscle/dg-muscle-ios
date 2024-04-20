//
//  UserRepositoryV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//
import Combine
import Foundation

protocol UserRepositoryV2 {
    var user: DGUser? { get }
    var userPublisher: AnyPublisher<DGUser?, Never> { get }
    var isLogin: Bool { get }
    var isLoginPublisher: AnyPublisher<Bool, Never> { get }
    
    func signOut() throws
    func updateUser(displayName: String?, photoURL: URL?) async throws
    func updateUser(displayName: String?) async throws
    func updateUser(photoURL: URL?) async throws
    func withDrawal() async -> Error?
}
