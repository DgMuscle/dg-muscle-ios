//
//  SubscribeUserUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class SubscribeUserUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement() -> AnyPublisher<UserDomain?, Never> {
        userRepository.userPublisher
    }
}
