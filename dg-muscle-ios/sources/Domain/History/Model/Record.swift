//
//  Record.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct Record {
    let id: String
    let exerciseId: String
    let sets: [ExerciseSet]
    
    var volume: Double {
        sets.reduce(0, { $0 + $1.volume })
    }
}
