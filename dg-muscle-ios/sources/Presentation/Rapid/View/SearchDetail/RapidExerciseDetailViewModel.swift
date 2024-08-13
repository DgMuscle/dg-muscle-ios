//
//  RapidExerciseDetailViewModel.swift
//  Weight
//
//  Created by Happymoonday on 8/13/24.
//

import Foundation
import Combine
import Domain

final class RapidExerciseDetailViewModel: ObservableObject {
    let data: RapidExercisePresentation
    @Published var showsSecondaryMuscles: Bool = false
    @Published var showsAddButton: Bool = false
    @Published var snackbarMessage: String?
    @Published var loading: Bool = false
    
    private let checkAddableExerciseUsecase: CheckAddableExerciseUsecase
    private let registerRapidExerciseUsecase: RegisterRapidExerciseUsecase
    
    init(
        exercise: Domain.RapidExerciseDomain,
        exerciseRepository: ExerciseRepository
    ) {
        data = .init(domain: exercise)
        
        checkAddableExerciseUsecase = .init()
        registerRapidExerciseUsecase = .init(exerciseRepository: exerciseRepository)
        
        showsAddButton = checkAddableExerciseUsecase.implement(exercise: data.domain)
    }
    
    @MainActor
    func add() {
        Task {
            guard loading == false else { return }
            loading = true
            do {
                try await registerRapidExerciseUsecase.implement(exercise: data.domain)
                snackbarMessage = "Exercise Registered!"
            } catch {
                snackbarMessage = error.localizedDescription
            }
            loading = false
        }
    }
}
