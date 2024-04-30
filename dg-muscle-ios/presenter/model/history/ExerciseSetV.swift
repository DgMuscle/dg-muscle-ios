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
        unit = Self.convert(unit: from.unit)
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
        .init(id: id, unit: Self.convert(unit: unit), reps: reps, weight: weight)
    }
    
    var volume: Double {
        Double(reps) * weight
    }
    
    static func convert(unit: ExerciseSetDomain.Unit) -> Unit {
        switch unit {
        case .kg:
            return .kg
        case .lbs:
            return .lbs
        }
    }
    
    static func convert(unit: Unit) -> ExerciseSetDomain.Unit {
        switch unit {
        case .kg:
            return .kg
        case .lbs:
            return .lbs
        }
    }
}

extension ExerciseSetV {
    enum Unit: String {
        case kg
        case lbs
    }
}
