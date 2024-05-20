//
//  UserRepository.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Combine

public protocol UserRepository {
    var user: AnyPublisher<User?, Never> { get }
    
    func get() -> User?
    
    func post(_ heatMapColor: HeatMapColor) throws
    func post(fcmToken: String)
    
    func signOut() throws
    func updateUser(displayName: String?, photoURL: URL?) async throws
    func withDrawal() async -> Error?
}
