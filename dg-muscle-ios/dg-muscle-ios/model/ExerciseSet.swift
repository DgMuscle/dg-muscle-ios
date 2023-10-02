//
//  ExerciseSet.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseSet: Codable, Equatable, Hashable {
    let unit: Unit
    var reps: Int
    let weight: Double
}

extension ExerciseSet {
    enum Unit: String, Codable {
        case kg
        case lb
    }
}
