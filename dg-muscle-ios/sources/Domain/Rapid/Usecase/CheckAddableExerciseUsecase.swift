//
//  CheckAddableExerciseUsecase.swift
//  Domain
//
//  Created by Happymoonday on 8/13/24.
//

import Foundation

public final class CheckAddableExerciseUsecase {
    
    public init() { }
    
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
