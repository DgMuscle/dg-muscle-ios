//
//  SubscribeIsAppReadyUseCase.swift
//  Domain
//
//  Created by 신동규 on 7/7/24.
//

import Foundation
import Combine

public final class SubscribeIsAppReadyUseCase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() -> AnyPublisher<Bool, Never> {
        userRepository.isAppReady
    }
}
