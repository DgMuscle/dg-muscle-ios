//
//  SubscribeExercisesUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine

public final class SubscribeExercisesUsecase {
    private let exerciseRepository: ExerciseRepository
    
    public init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    public func implement() -> AnyPublisher<[Exercise], Never> {
        exerciseRepository.exercises
    }
}
