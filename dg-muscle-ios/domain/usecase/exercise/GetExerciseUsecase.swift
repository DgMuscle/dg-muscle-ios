//
//  GetExerciseUsecase.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/29/24.
//

import Foundation

final class GetExerciseUsecase {
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(exerciseId: String) -> ExerciseDomain? {
        exerciseRepository.get(exerciseId: exerciseId)
    }
}
