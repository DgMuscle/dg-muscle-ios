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
        
        guard let maxWeight = record.sets.sorted(by: { $0.weight > $1.weight }).first?.weight else { return result }
        var sets = record.sets
        
        sets = sets
            .filter({ $0.weight >= maxWeight })
        
        result = sets.count >= 5
        
        return result
    }
}
