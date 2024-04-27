//
//  RecordData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct RecordData: Codable {
    let id: String
    let exerciseId: String
    let sets: [ExerciseSetData]
    
    init(from: RecordDomain) {
        id = from.id
        exerciseId = from.exerciseId
        sets = from.sets.map({ .init(from: $0) })
    }
    
    var domain: RecordDomain {
        .init(id: id, exerciseId: exerciseId, sets: sets.map({ $0.domain }))
    }
}
