//
//  GetExercisesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

final class GetExercisesUsecase {
    let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement() -> [ExerciseDomain] {
        exerciseRepository.exercises
    }
}
