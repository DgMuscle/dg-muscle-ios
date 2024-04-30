//
//  ExerciseSetData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct ExerciseSetData: Codable {
    let id: String
    let weight: Double
    let reps: Int
    let unit: Unit
    
    init(from: ExerciseSetDomain) {
        id = from.id
        weight = from.weight
        reps = from.reps
        unit = Self.convert(unit: from.unit)
    }
    
    var domain: ExerciseSetDomain {
        .init(id: id, unit: Self.convert(unit: unit), reps: reps, weight: weight)
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

extension ExerciseSetData {
    enum Unit: String, Codable {
        case kg
        case lbs
    }
}
