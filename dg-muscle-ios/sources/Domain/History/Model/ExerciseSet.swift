//
//  ExerciseSet.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct ExerciseSet {
    let id: String
    let unit: Unit
    let reps: Int
    let weight: Double
    
    var volume: Double {
        weight * Double(reps)
    }
}
