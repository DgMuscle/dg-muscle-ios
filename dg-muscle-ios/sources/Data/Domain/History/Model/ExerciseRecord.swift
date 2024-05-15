//
//  ExerciseRecord.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct ExerciseRecord: Codable {
    let id: String
    let exerciseId: String
    let sets: [ExerciseSet]
    
    init(domain: Domain.ExerciseRecord) {
        self.id = domain.id
        self.exerciseId = domain.exerciseId
        self.sets = domain.sets.map({ .init(domain: $0) })
    }
    
    var domain: Domain.ExerciseRecord {
        .init(id: id, exerciseId: exerciseId, sets: sets.map({ $0.domain }))
    }
}

