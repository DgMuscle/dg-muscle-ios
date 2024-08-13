//
//  RegisterRapidExerciseUsecase.swift
//  Domain
//
//  Created by Happymoonday on 8/13/24.
//

import Foundation

public final class RegisterRapidExerciseUsecase {
    private let exerciseRepository: ExerciseRepository
    
    public init(exerciseRepository: ExerciseRepository) {
        self.exerciseRepository = exerciseRepository
    }
    
    public func implement(exercise: RapidExerciseDomain) async throws {
        var exerciseDomain: Exercise?
        
        var parts: [Exercise.Part] = []
        
        switch exercise.bodyPart {
        case .back:
            parts.append(.back)
        case .chest:
            parts.append(.chest)
        case .lowerArms, .upperArms:
            parts.append(.arm)
        case .lowerLegs, .upperLegs:
            parts.append(.leg)
        case .shoulders:
            parts.append(.shoulder)
        case .waist:
            parts.append(.core)
        case .cardio, .neck:
            break
        }
        
        guard parts.isEmpty == false else { return }
        
        exerciseDomain = .init(
            id: exercise.name.filter({ $0.isLetter }),
            name: exercise.name,
            parts: parts,
            favorite: true
        )
        
        guard let exerciseDomain else { return }
        try await exerciseRepository.post(exerciseDomain)
    }
}
