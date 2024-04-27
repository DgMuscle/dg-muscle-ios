//
//  ExerciseSetV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct ExerciseSetV {
    let id: String
    let unit: Unit
    let reps: Int
    let weight: Double
    
    init(from: ExerciseSetDomain) {
        id = from.id
        unit = .init(rawValue: from.unit.rawValue) ?? .kg
        reps = from.reps
        weight = from.weight
    }
    
    var domain: ExerciseSetDomain {
        .init(id: id, unit: .init(rawValue: unit.rawValue) ?? .kg, reps: reps, weight: weight)
    }
}

extension ExerciseSetV {
    enum Unit: String {
        case kg
        case lb
    }
}
