//
//  UserRepository.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Combine

public protocol UserRepository {
    var user: AnyPublisher<UserDomain?, Never> { get }
}
