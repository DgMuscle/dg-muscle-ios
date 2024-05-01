//
//  ExerciseEditViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class ExerciseEditViewModel: ObservableObject {
    private var exercise: ExerciseV
    let editExerciseUsecase: EditExerciseUsecase
    
    @Published var name: String
    @Published var parts: [ExerciseV.Part]
    @Published var favorite: Bool
    
    init(exercise: ExerciseV, editExerciseUsecase: EditExerciseUsecase) {
        self.exercise = exercise
        self.editExerciseUsecase = editExerciseUsecase
        
        name = exercise.name
        parts = exercise.parts
        favorite = exercise.favorite
    }
    
    func update() {
        exercise.name = name
        exercise.parts = parts
        exercise.favorite = favorite
        
        editExerciseUsecase.implement(data: exercise.domain)
    }
}
