//
//  ExerciseRepositoryTest.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class ExerciseRepositoryTest: ExerciseRepository {
    var exercises: [ExerciseDomain] { _exercises }
    var exercisesPublisher: AnyPublisher<[ExerciseDomain], Never> { $_exercises.eraseToAnyPublisher() }
    @Published private var _exercises: [ExerciseDomain] = []
    
    init() {
        prepareMockData()
    }
    
    func post(data: ExerciseDomain) async throws {
        _exercises.append(data)
    }
    
    func edit(data: ExerciseDomain) async throws {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises[index] = data
        }
    }
    
    func delete(data: ExerciseDomain) async throws {
        if let index = exercises.firstIndex(where: { $0.id == data.id }) {
            _exercises.remove(at: index)
        }
    }
    
    func get(exerciseId: String) -> ExerciseDomain? {
        return exercises.first(where: { $0.id == exerciseId })
    }
    
    private func prepareMockData() {
        _exercises = [
            .init(id: "squat", name: "squat", parts: [.leg], favorite: true),
            .init(id: "bench press", name: "bench press", parts: [.chest, .arm], favorite: true),
            .init(id: "leg press", name: "leg press", parts: [.leg], favorite: false),
            .init(id: "pull up", name: "pull up", parts: [.back], favorite: true),
            .init(id: "arm curl", name: "arm curl", parts: [.arm], favorite: false)
        ]
    }
}
