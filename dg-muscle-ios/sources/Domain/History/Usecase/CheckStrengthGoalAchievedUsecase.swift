//
//  CheckStrengthGoalAchievedUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation

public final class CheckStrengthGoalAchievedUsecase {
    public init() { }
    
    public func implement(goal: ExerciseSet, record: ExerciseRecord) -> Bool {
        var result: Bool = false
        
        var sets = record.sets
        
        sets = sets
            .filter({ $0.weight >= goal.weight && $0.reps >= goal.reps })
        
        result = sets.count >= 5
        
        return result
    }
}
