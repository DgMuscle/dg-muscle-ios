//
//  SubscribeUserUsecase.swift
//  App
//
//  Created by Donggyu Shin on 5/14/24.
//

import Foundation
import Combine

public final class SubscribeUserUsecase {
    let userRepository: UserRepository
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() -> AnyPublisher<UserDomain?, Never> {
        userRepository.user
    }
}
