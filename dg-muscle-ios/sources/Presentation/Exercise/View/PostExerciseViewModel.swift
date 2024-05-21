//
//  PostExerciseViewModel.swift
//  Exercise
//
//  Created by Donggyu Shin on 5/21/24.
//

import Foundation
import Combine
import Domain
import Common

final class PostExerciseViewModel: ObservableObject {
    @Published var exercise: Exercise
    @Published var status: StatusView.Status? = nil
    
    private let postExerciseUsecase: PostExerciseUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        exercise: Exercise?,
        exerciseRepository: ExerciseRepository
    ) {
        self.exercise = exercise ?? .init()
        self.postExerciseUsecase = .init(exerciseRepository: exerciseRepository)
    }
    
    @MainActor
    func tapAdd() {
        Task {
            status = nil
            var notEnoughParameter: Bool = false
            notEnoughParameter = exercise.name.isEmpty
            notEnoughParameter = exercise.parts.isEmpty
            
            if notEnoughParameter {
                status = .error("Exercise name and parts must be filled.")
                return
            }
            status = .success(nil)
            try await postExerciseUsecase.implement(exercise: exercise.domain)
        }
    }
}
