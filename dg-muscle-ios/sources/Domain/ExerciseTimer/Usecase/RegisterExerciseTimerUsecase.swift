//
//  RegisterExerciseTimerUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation

public final class RegisterExerciseTimerUsecase {
    private let exerciseTimerRepository: ExerciseTimerRepository
    
    public init(exerciseTimerRepository: ExerciseTimerRepository) {
        self.exerciseTimerRepository = exerciseTimerRepository
    }
    
    public func implement(timer: ExerciseTimerDomain) {
        exerciseTimerRepository.post(timer: timer)
    }
}
