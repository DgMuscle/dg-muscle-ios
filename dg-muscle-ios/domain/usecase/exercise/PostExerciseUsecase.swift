//
//  PostExerciseUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class PostExerciseUsecase {
    private let exerciseRepository: ExerciseRepository
    
    init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    func implement(name: String, parts: [ExerciseDomain.Part], isFavorite: Bool) {
        Task {
            let exercise: ExerciseDomain = .init(id: UUID().uuidString, name: name, parts: parts, favorite: isFavorite)
            try await exerciseRepository.post(data: exercise)
        }
    }
}
