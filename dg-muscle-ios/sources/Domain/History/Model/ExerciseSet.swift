//
//  ExerciseSet.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct ExerciseSet {
    public let id: String
    public let unit: Unit
    public var reps: Int
    public var weight: Double
    
    public init(id: String, unit: Unit, reps: Int, weight: Double) {
        self.id = id
        self.unit = unit
        self.reps = reps
        self.weight = weight
    }
    
    public var volume: Double {
        weight * Double(reps)
    }
}
