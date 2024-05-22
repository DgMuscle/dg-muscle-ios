//
//  ExerciseRecord.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

public struct ExerciseRecord: Hashable {
    let id: String
    let exerciseId: String
    var exerciseName: String?
    var sets: [ExerciseSet]
    var volume: Int {
        sets.map({ $0.volume }).reduce(0, +)
    }
    
    init(domain: Domain.ExerciseRecord) {
        id = domain.id
        exerciseId = domain.exerciseId
        sets = domain.sets.map({ .init(domain: $0) })
    }
    
    var domain: Domain.ExerciseRecord {
        .init(
            id: id,
            exerciseId: exerciseId,
            sets: sets.map({
                $0.domain
            })
        )
    }
}
