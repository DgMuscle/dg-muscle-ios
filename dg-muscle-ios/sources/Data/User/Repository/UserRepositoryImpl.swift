//
//  UserRepositoryImpl.swift
//  Data
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Combine
import Domain

final class UserRepositoryImpl: UserRepository {
    var user: AnyPublisher<UserDomain?, Never> { $_user.eraseToAnyPublisher() }
    @Published private var _user: UserDomain? = nil
}
