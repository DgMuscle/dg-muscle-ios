//
//  SearchRapidExercisesByNameUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/21/24.
//

import Foundation

public final class SearchRapidExercisesByNameUsecase {
    private let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement(name: String) -> [RapidExerciseDomain] {
        var result: [RapidExerciseDomain] = []
        
        let allExercises = rapidRepository.get()
        
        for exercise in allExercises {
            let exerciseName = exercise.name.trimmingCharacters(in: .whitespacesAndNewlines)
            if exerciseName.contains(name) {
                result.append(exercise)
            }
        }
        
        return result
    }
}
