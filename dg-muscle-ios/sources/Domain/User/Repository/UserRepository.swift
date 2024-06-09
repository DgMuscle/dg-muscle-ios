//
//  UserRepository.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Combine
import UIKit

public protocol UserRepository {
    var user: AnyPublisher<User?, Never> { get }
    
    func get() -> User?
    
    func post(_ heatMapColor: HeatMapColor) throws
    func post(fcmToken: String)
    
    func signOut() throws
    func updateUser(displayName: String?, photo: UIImage?) async throws
    func updateUser(displayName: String?) async throws
    func updateUser(photo: UIImage?) async throws
    func updateUser(backgroundImage: UIImage?) async throws
    func updateUser(link: URL?)
    func withDrawal() async -> Error?
}
