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
        var sets = previousRecord.sets
        guard let maxWeight = sets.map({ $0.weight }).max() else { return nil }
        return sets
            .filter({ $0.weight == maxWeight })
            .sorted(by: { $0.reps > $1.reps })
            .first
    }
}
