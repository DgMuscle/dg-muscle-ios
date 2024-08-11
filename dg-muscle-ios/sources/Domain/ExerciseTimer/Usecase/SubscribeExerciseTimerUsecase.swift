//
//  SubscribeExerciseTimerUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation
import Combine

public final class SubscribeExerciseTimerUsecase {
    private let exerciseTimerRepository: ExerciseTimerRepository
    
    public init(exerciseTimerRepository: ExerciseTimerRepository) {
        self.exerciseTimerRepository = exerciseTimerRepository
    }
    
    public func implement() -> AnyPublisher<ExerciseTimerDomain?, Never> {
        exerciseTimerRepository.timer.eraseToAnyPublisher()
    }
}
