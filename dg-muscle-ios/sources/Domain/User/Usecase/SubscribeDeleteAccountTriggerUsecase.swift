//
//  SubscribeDeleteAccountTriggerUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation
import Combine

public final class SubscribeDeleteAccountTriggerUsecase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() -> PassthroughSubject<(), Never> {
        userRepository.startDeleteAccount
    }
}
