//
//  ExerciseRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

public final class ExerciseRepositoryMock: ExerciseRepository {
    
    public var exercises: AnyPublisher<[Domain.Exercise], Never> { $_exercises.eraseToAnyPublisher() }
    
    @Published var _exercises: [Exercise]
    
    public init() {
        _exercises = exercisesFromJsonResponse
    }
    
    public func get() -> [Domain.Exercise] {
        _exercises
    }
    
    public func post(_ exercise: Domain.Exercise) async throws {
        if let index = _exercises.firstIndex(where: { $0.id == exercise.id }) {
            _exercises[index] = exercise
        } else {
            _exercises.append(exercise)
        }
    }
    
    public func delete(_ exercise: Domain.Exercise) async throws {
        if let index = _exercises.firstIndex(where: { $0.id == exercise.id }) {
            _exercises.remove(at: index)
        }
    }
}
