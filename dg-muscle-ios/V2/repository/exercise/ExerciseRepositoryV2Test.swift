//
//  ExerciseRepositoryV2Test.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

final class ExerciseRepositoryV2Test: ExerciseRepositoryV2 {
    var exercises: [Exercise] {
        _exercises
    }
    
    var exercisesPublisher: AnyPublisher<[Exercise], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published private var _exercises: [Exercise] = []
    
    init() {
        prepareMockData()
    }
    
    private func prepareMockData() {
        _exercises = [
            .init(id: "squat", name: "squat", parts: [.leg], favorite: true, order: 0, createdAt: nil),
            .init(id: "bench press", name: "bench press", parts: [.chest], favorite: true, order: 1, createdAt: nil),
            .init(id: "leg press", name: "leg press", parts: [.leg], favorite: false, order: 2, createdAt: nil),
            .init(id: "pull up", name: "pull up", parts: [.back], favorite: true, order: 3, createdAt: nil),
        ]
    }
}


