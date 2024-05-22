//
//  ExerciseSet.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

struct ExerciseSet: Hashable {
    let id: String
    let unit: Unit
    let reps: Int
    let weight: Double
    
    init(domain: Domain.ExerciseSet) {
        id = domain.id
        unit = .init(domain: domain.unit)
        reps = domain.reps
        weight = domain.weight
    }
    
    var domain: Domain.ExerciseSet {
        .init(
            id: id,
            unit: unit.domain,
            reps: reps,
            weight: weight
        )
    }
}
