//
//  EditExerciseViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import Foundation
import Combine

final class EditExerciseViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var errorMessage: String?
    @Published var exercise: Exercise
    
    let exerciseRepository: ExerciseRepositoryV2
    let completeAction: (() -> ())?
    
    init(exercise: Exercise,
         exerciseRepository: ExerciseRepositoryV2,
         completeAction: (() -> ())?) {
        self.exercise = exercise
        self.exerciseRepository = exerciseRepository
        self.completeAction = completeAction
    }
    
    @MainActor
    func update() {
        Task {
            guard exercise.parts.isEmpty == false else {
                errorMessage = "Please choose at least one part"
                return
            }
            guard loading == false else { return }
            loading = true
            do {
                let _ = try await exerciseRepository.edit(data: exercise)
                completeAction?()
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
    }
}