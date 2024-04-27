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
        unit = .init(rawValue: from.unit.rawValue) ?? .kg
    }
    
    var domain: ExerciseSetDomain {
        .init(id: id, unit: .init(rawValue: unit.rawValue) ?? .kg, reps: reps, weight: weight)
    }
}

extension ExerciseSetData {
    enum Unit: String, Codable {
        case kg
        case lb
    }
}
