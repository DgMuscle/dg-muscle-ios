//
//  RecordData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct RecordData: Codable {
    let id: String
    let exerciseId: String
    let sets: [ExerciseSetData]
}
