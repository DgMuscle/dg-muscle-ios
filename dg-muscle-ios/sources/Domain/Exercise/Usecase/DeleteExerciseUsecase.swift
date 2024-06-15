//
//  DeleteExerciseUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/19/24.
//

import Foundation

public final class DeleteExerciseUsecase {
    private let exerciseRepository: ExerciseRepository
    public init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    public func implement(exercise: Exercise) async throws {
        try await exerciseRepository.delete(exercise)
    }
}
