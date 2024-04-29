//
//  ExerciseSetV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct ExerciseSetV: Equatable, Identifiable {
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
    
    init(id: String, reps: Int, weight: Double) {
        self.id = id
        self.reps = reps
        self.weight = weight
        self.unit = .kg
    }
    
    var domain: ExerciseSetDomain {
        .init(id: id, unit: .init(rawValue: unit.rawValue) ?? .kg, reps: reps, weight: weight)
    }
    
    var volume: Double {
        Double(reps) * weight
    }
}

extension ExerciseSetV {
    enum Unit: String {
        case kg
        case lbs
    }
}
