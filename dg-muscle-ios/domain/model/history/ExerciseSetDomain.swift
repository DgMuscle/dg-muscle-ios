//
//  ExerciseSet.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct ExerciseSetDomain {
    let id: String
    let unit: Unit
    let reps: Int
    let weight: Double
}

extension ExerciseSetDomain {
    enum Unit: String {
        case kg
        case lb
    }
}
