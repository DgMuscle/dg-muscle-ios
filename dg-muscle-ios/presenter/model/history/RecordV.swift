//
//  RecordV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct RecordV: Equatable {
    let id: String
    let exerciseId: String
    var sets: [ExerciseSetV]
    
    init(from: RecordDomain) {
        id = from.id
        exerciseId = from.exerciseId
        sets = from.sets.map({ .init(from: $0) })
    }
    
    var domain: RecordDomain {
        .init(id: id, exerciseId: exerciseId, sets: sets.map({ $0.domain }))
    }
    
    var volume: Double {
        sets.reduce(0, { $0 + $1.volume })
    }
}
