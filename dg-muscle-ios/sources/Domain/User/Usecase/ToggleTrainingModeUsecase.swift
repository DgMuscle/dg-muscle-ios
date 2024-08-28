//
//  ToggleTrainingModeUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/28/24.
//

public final class ToggleTrainingModeUsecase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() {
        guard let user: User = userRepository.get() else { return }
        let previousTrainingMode = user.trainingMode
        let nextTrainigMode: TrainingMode
        
        switch previousTrainingMode {
        case .mass:
            nextTrainigMode = .strength
        case .strength:
            nextTrainigMode = .mass
        }
        
        userRepository.updateUser(trainingMode: nextTrainigMode)
    }
}
