//
//  ExerciseSet.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseSet: Codable, Hashable {
    let unit: Unit
    let reps: Int
    let weight: Int
    var id: String? = UUID().uuidString
}

extension ExerciseSet {
    enum Unit: String, Codable {
        case kg
        case lb
    }
}
