//
//  CheckGoalAchievedUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/13/24.
//

import Foundation

public final class CheckGoalAchievedUsecase {
    public init() { }
    
    public func implement(goal: ExerciseSet, record: ExerciseRecord) -> Bool {
        return !record.sets.filter({ set in
            goal.weight <= set.weight && goal.reps <= set.reps
        }).isEmpty
    }
}
