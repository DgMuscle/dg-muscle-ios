//
//  GetRecordGoalUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/26/24.
//

import Foundation

/// Recommends Goal of ExerciseSet
public final class GetRecordGoalUsecase {
    public init() { }
    
    public func implement(previousRecord: ExerciseRecord) -> ExerciseSet? {
        let sets = previousRecord.sets
        guard let maxWeight = sets.map({ $0.weight }).max() else { return nil }
        guard var set = sets
            .filter({ $0.weight == maxWeight })
            .sorted(by: { $0.reps > $1.reps })
            .first else { return nil }
        
        if set.reps >= 15 {
            set.weight += 5
            set.reps = 10
        } else {
            set.reps = set.reps + 1
        }
        
        return set
    }
}
