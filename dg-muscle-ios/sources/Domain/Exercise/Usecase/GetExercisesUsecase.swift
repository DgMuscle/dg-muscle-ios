//
//  GetExercisesUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/22/24.
//

import Foundation

public final class GetExercisesUsecase {
    private let exerciseRepository: ExerciseRepository
    public init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    public func implement() -> [Exercise] {
        exerciseRepository.get()
    }
}
