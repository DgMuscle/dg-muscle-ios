//
//  ExerciseSet.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct ExerciseSet: Codable {
    let id: String
    let unit: Unit
    let reps: Int
    let weight: Double
    
    init(domain: Domain.ExerciseSet) {
        self.id = domain.id
        self.unit = .init(domain: domain.unit)
        self.reps = domain.reps
        self.weight = domain.weight
    }
    
    var domain: Domain.ExerciseSet {
        .init(id: id, unit: unit.domain, reps: reps, weight: weight)
    }
}

