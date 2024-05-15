//
//  Record.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct Record {
    public let id: String
    public let exerciseId: String
    public let sets: [ExerciseSet]
    
    public init(id: String, exerciseId: String, sets: [ExerciseSet]) {
        self.id = id
        self.exerciseId = exerciseId
        self.sets = sets
    }
    
    public var volume: Double {
        sets.reduce(0, { $0 + $1.volume })
    }
}
