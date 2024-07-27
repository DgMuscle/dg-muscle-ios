//
//  GetRecordGoalStrengthUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation

/// Recommends Goal of ExerciseSet for strength
public final class GetRecordGoalStrengthUsecase {
    public init() { }
    
    public func implement(previousRecord: ExerciseRecord) -> ExerciseSet? {
        var result: ExerciseSet?
        var sets = previousRecord.sets
        guard let maxWeight = sets.map({ $0.weight }).max() else { return nil }
        var goalWeight = maxWeight
        sets = sets.filter({ $0.weight >= maxWeight && $0.reps >= 5 })
        
        if sets.count >= 5 {
            goalWeight += 5
        }
        
        result = .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: goalWeight)
        return result
    }
}
