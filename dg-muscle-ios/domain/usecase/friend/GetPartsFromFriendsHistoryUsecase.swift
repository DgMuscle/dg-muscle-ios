//
//  GetPartsFromFriendsHistoryUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation

final class GetPartsFromFriendsHistoryUsecase {
    func implement(history: HistoryDomain, exercises: [ExerciseDomain]) -> [ExerciseDomain.Part] {
        let exerciseIds = history.records.map { $0.exerciseId }
        var exercises = exercises
        
        exercises = exercises.filter({
            exerciseIds.contains($0.id)
        })
        
        var parts: [ExerciseDomain.Part] = exercises.flatMap({ $0.parts })
        parts = Array(Set(parts))
        parts.sort()
        return parts
    }
}
