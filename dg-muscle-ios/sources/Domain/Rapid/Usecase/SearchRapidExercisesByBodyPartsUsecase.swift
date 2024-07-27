//
//  SearchRapidExercisesByBodyPartsUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/21/24.
//

import Foundation

public final class SearchRapidExercisesByBodyPartsUsecase {
    private let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement(parts: [RapidBodyPartDomain]) -> [RapidExerciseDomain] {
        var result: [RapidExerciseDomain] = []
        
        let allExercises = rapidRepository.get()
        
        for exercise in allExercises {
            if parts.contains(exercise.bodyPart) {
                result.append(exercise)
            }
        }
        
        return result
    }
}
