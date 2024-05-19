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
    
    func signOut() throws
    func updateUser(displayName: String?, photoURL: URL?) async throws
    func withDrawal() async -> Error?
    func post(_ heatMapColor: HeatMapColor) throws
}
