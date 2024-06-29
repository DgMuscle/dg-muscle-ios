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
    @Published var isPartsSelectionVisible: Bool = false
    @Published var isSaveButtonVisible: Bool = false
    
    private let postExerciseUsecase: PostExerciseUsecase
    private let pop: (() -> ())?
    
    init(
        exercise: Exercise?,
        exerciseRepository: ExerciseRepository,
        pop: (() -> ())?
    ) {
        self.exercise = exercise ?? .init()
        self.postExerciseUsecase = .init(exerciseRepository: exerciseRepository)
        self.pop = pop
        bind()
    }
    
    @MainActor
    func save() {
        Task {
            status = nil
            var notEnoughParameter: Bool = false
            notEnoughParameter = exercise.name.isEmpty
            notEnoughParameter = exercise.parts.isEmpty
            
            if notEnoughParameter {
                status = .error("Exercise name and parts must be filled.")
                return
            }
            pop?()
            try await postExerciseUsecase.implement(exercise: exercise.domain)
        }
    }
    
    private func bind() {
        $exercise
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({ !$0.name.isEmpty && !$0.parts.isEmpty })
            .assign(to: &$isSaveButtonVisible)
        
        $exercise
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({ !$0.name.isEmpty })
            .assign(to: &$isPartsSelectionVisible)
    }
}
