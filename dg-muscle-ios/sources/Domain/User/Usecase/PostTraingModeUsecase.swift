//
//  PostTraingModeUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation

public final class PostTraingModeUsecase {
    let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement(mode: TrainingMode) {
        userRepository.updateUser(trainingMode: mode)
    }
}
