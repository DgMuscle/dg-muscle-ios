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
    public var isAppReady: AnyPublisher<Bool, Never> {
        $isReady.eraseToAnyPublisher()
    }
    public var startDeleteAccount: PassthroughSubject<(), Never> = .init()
    @Published var _user: Domain.User? = USER_DG
    @Published var isReady: Bool = true
    
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
    
    public func updateUser(backgroundImage: UIImage?) async throws {
        
    }
    
    public func updateUser(link: URL?) {
        _user?.link = link
    }
    
    public func updateUser(onlyShowsFavoriteExercises: Bool) {
        _user?.onlyShowsFavoriteExercises = onlyShowsFavoriteExercises
    }
    
    public func updateUser(trainingMode: TrainingMode) {
        _user?.trainingMode = trainingMode
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
