//
//  SubscribeTrainingModeUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Combine

public final class SubscribeTrainingModeUsecase {
    
    @Published private var traingMode: TrainingMode
    
    let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        traingMode = userRepository.get()?.trainingMode ?? .mass
        
        bind()
    }
    
    public func implement() -> AnyPublisher<TrainingMode, Never> {
        $traingMode.eraseToAnyPublisher()
    }
    
    private func bind() {
        userRepository
            .user
            .compactMap({ $0?.trainingMode })
            .assign(to: &$traingMode)
    }
}
