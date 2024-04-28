//
//  ExerciseManageViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class ExerciseManageViewModel: ObservableObject {
    let deleteExerciseUsecase: DeleteExerciseUsecase
    
    init(deleteExerciseUsecase: DeleteExerciseUsecase) {
        self.deleteExerciseUsecase = deleteExerciseUsecase
    }
    
    func delete(exercise: ExerciseV) {
        deleteExerciseUsecase.implement(exercise: exercise.domain)
    }
}
