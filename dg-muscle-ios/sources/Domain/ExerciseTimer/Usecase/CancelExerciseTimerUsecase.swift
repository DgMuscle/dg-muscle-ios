//
//  CancelExerciseTimerUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/11/24.
//

import Foundation

public final class CancelExerciseTimerUsecase {
    private let exerciseTimerRepository: ExerciseTimerRepository
    
    public init(exerciseTimerRepository: ExerciseTimerRepository) {
        self.exerciseTimerRepository = exerciseTimerRepository
    }
    
    public func implement() {
        exerciseTimerRepository.delete()
    }
}
