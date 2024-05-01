//
//  EditExerciseUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class EditExerciseUsecase {
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(data: ExerciseDomain) {
        Task {
            try await exerciseRepository.edit(data: data)
        }
    }
}
