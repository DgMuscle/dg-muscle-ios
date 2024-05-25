//
//  UserRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain
import Combine
import UIKit

public final class UserRepositoryMock: UserRepository {
    public var user: AnyPublisher<Domain.User?, Never> { $_user.eraseToAnyPublisher() }
    @Published var _user: Domain.User? = USER_DG
    
    public init() {
        
    }
    
    public func signOut() throws {
        _user = nil 
    }
    
    public func updateUser(displayName: String?) async throws {
        _user?.displayName = displayName
    }
    
    public func updateUser(displayName: String?, photo: UIImage?) async throws {
        _user?.displayName = displayName
    }
    
    public func updateUser(photo: UIImage?) async throws {
        
    }
    
    public func withDrawal() async -> (any Error)? {
        nil
    }
    
    public func post(_ heatMapColor: Domain.HeatMapColor) throws {
        _user?.heatMapColor = heatMapColor
    }
    
    public func post(fcmToken: String) {
        _user?.fcmToken = fcmToken
    }
    
    public func get() -> Domain.User? {
        _user
    }
}
