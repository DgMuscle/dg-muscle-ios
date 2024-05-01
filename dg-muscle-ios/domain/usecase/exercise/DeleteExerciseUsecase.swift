//
//  DeleteExerciseUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class DeleteExerciseUsecase {
    private let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(exercise: ExerciseDomain) {
        Task {
            try await exerciseRepository.delete(data: exercise)
        }
    }
}
