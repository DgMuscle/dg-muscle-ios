//
//  ExerciseSet.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseSet: Codable, Identifiable {
    var id = UUID().uuidString
    let unit: Unit
    let reps: Int
    let weight: Int
}

extension ExerciseSet {
    enum Unit: String, Codable {
        case kg
        case lb
    }
}
