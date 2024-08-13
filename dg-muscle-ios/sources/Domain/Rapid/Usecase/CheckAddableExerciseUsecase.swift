//
//  CheckAddableExerciseUsecase.swift
//  Domain
//
//  Created by Happymoonday on 8/13/24.
//

import Foundation

public final class CheckAddableExerciseUsecase {
    private let rapidRepository: RapidRepository
    
    public init(rapidRepository: RapidRepository) {
        self.rapidRepository = rapidRepository
    }
    
    public func implement(exercise: RapidExerciseDomain) -> Bool {
        var result: Bool = false
        
        switch exercise.bodyPart {
            
        case .back,
                .chest,
                .lowerArms,
                .lowerLegs,
                .shoulders,
                .upperArms,
                .waist,
                .upperLegs:
            result = true
        case .cardio, .neck:
            break
        }
        
        return result
    }
}
