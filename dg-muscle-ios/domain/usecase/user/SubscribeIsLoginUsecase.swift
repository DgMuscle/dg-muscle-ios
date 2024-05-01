//
//  SubscribeIsLoginUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation
import Combine

final class SubscribeIsLoginUsecase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement() -> AnyPublisher<Bool, Never> {
        userRepository.isLoginPublisher
    }
}
