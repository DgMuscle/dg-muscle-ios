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
}

extension ExerciseSetData {
    enum Unit: String, Codable {
        case kb
        case lb
    }
}
