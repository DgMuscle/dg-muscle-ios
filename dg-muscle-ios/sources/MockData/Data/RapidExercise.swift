//
//  RapidExercise.swift
//  MockData
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain

public var RAPID_EXERCISES: [Domain.RapidExerciseDomain] {
    
    guard let filePath = Bundle(for: ForBundle.self).url(forResource: "rapid_exercises_response", withExtension: "json") else { return [] }
    guard let data = try? Data(contentsOf: filePath) else { return [] }
    let decoder = JSONDecoder()
    guard let exercises: [RapidExerciseMockData] = try? decoder.decode([RapidExerciseMockData].self, from: data) else { return [] }
    return exercises.compactMap({ $0.domain })
}

private class ForBundle { }
