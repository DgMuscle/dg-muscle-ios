//
//  UserRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain
import Combine

public final class UserRepositoryMock: UserRepository {
    public var user: AnyPublisher<Domain.User?, Never> { $_user.eraseToAnyPublisher() }
    @Published var _user: Domain.User? = USER_DG
    
    public init() {
        
    }
    
    public func signOut() throws {
        _user = nil 
    }
    
    public func updateUser(displayName: String?, photoURL: URL?) async throws {
        _user?.displayName = displayName
        _user?.photoURL = photoURL
    }
    
    public func updateUser(displayName: String?) async throws {
        _user?.displayName = displayName
    }
    
    public func updateUser(photoURL: URL?) async throws {
        _user?.photoURL = photoURL
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
