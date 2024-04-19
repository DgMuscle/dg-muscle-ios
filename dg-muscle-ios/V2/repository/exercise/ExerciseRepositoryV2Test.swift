//
//  ExerciseRepositoryV2Test.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

class ExerciseRepositoryV2Test: ExerciseRepositoryV2 {
    var exercises: [Exercise] {
        _exercises
    }
    
    var exercisesPublisher: AnyPublisher<[Exercise], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published fileprivate var _exercises: [Exercise] = []
    
    init() {
        prepareMockData()
    }
    
    func post(data: Exercise) async throws -> DefaultResponse {
        return .init(ok: true, message: nil)
    }
    
    func edit(data: Exercise) async throws -> DefaultResponse {
        return .init(ok: true, message: nil)
    }
    
    func delete(data: Exercise) async throws -> DefaultResponse {
        return .init(ok: true, message: nil)
    }
    
    func get(exerciseId: String) -> Exercise? {
        exercises.first(where: { $0.id == exerciseId })
    }
    
    fileprivate func prepareMockData() {
        _exercises = [
            .init(id: "squat", name: "squat", parts: [.leg], favorite: true, order: 0, createdAt: nil),
            .init(id: "bench press", name: "bench press", parts: [.chest, .arm], favorite: true, order: 1, createdAt: nil),
            .init(id: "leg press", name: "leg press", parts: [.leg], favorite: false, order: 2, createdAt: nil),
            .init(id: "pull up", name: "pull up", parts: [.back], favorite: true, order: 3, createdAt: nil),
        ]
    }
}

final class ExerciseRepositoryV3Test: ExerciseRepositoryV2Test {
    override func prepareMockData() {
        _exercises = []
    }
}
