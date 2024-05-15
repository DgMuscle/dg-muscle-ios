//
//  ExerciseRepository.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

final class ExerciseRepository: Domain.ExerciseRepository {
    var exercises: AnyPublisher<[Exercise], Never> { $_exercises.eraseToAnyPublisher() }
    @Published var _exercises: [Exercise] = []
    
    init() {
        prepareExercisesData()
    }
    
    private func prepareExercisesData() {
        _exercises = [
            .init(id: "squat", name: "Squat", parts: [.leg], favorite: true),
            .init(id: "bench press", name: "Bench Press", parts: [.chest], favorite: false),
            .init(id: "deadlift", name: "Deadlift", parts: [.leg, .back], favorite: true)
        ]
    }
}
