//
//  Record.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct Record: Codable, Equatable, Identifiable {
    var id: String? = UUID().uuidString
    let exerciseId: String
    let sets: [ExerciseSet]
}
