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
}
