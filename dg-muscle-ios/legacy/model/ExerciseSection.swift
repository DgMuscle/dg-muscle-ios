//
//  ExerciseSection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/9/23.
//

import Foundation

struct ExerciseSection: Identifiable {
    let id = UUID().uuidString
    let part: Exercise.Part
    let exercises: [Exercise]
}
