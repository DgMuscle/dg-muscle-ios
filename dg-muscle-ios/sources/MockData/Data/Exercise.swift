//
//  Exercise.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public var EXERCISES: [Domain.Exercise] {
    
    let bundle = Bundle(for: ForBundle.self)
    
    if let url = bundle.url(forResource: "exercises", withExtension: "json") {
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let exercises: [ExerciseMockData] = try? decoder.decode([ExerciseMockData].self, from: data) {
                return exercises.map({ $0.domain })
            }
        }
    }
    
    return []
}

private class ForBundle { }
