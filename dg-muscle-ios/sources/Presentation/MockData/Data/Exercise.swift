//
//  Exercise.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public let EXERCISE_SQUAT: Exercise = .init(id: "squat", name: "Squat", parts: [.leg], favorite: true)
public let EXERCISE_BENCH: Exercise = .init(id: "bench press", name: "Bench Press", parts: [.chest], favorite: false)
public let EXERCISE_DEAD: Exercise = .init(id: "deadlift", name: "Deadlift", parts: [.leg, .back], favorite: false)
