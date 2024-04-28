//
//  ExerciseSectionV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct ExerciseSectionV: Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(part)
    }
    var id: Int { part.hashValue }
    let part: ExerciseV.Part
    let exercises: [ExerciseV]
}
