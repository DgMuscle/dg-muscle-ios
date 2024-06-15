//
//  ExerciseSet.swift
//  Friend
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

struct ExerciseSet: Hashable, Identifiable {
    let id: String
    var unit: Unit
    var reps: Int
    var weight: Double
    var volume: Int { reps * Int(weight) }
    
    init(
        unit: Unit,
        reps: Int,
        weight: Double
    ) {
        id = UUID().uuidString
        self.unit = unit
        self.reps = reps
        self.weight = weight
    }
    
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
