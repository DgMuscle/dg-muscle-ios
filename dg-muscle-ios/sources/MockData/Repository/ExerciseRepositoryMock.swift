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
    @Published var _exercises: [Exercise] = [
        EXERCISE_SQUAT,
        EXERCISE_BENCH,
        EXERCISE_DEAD
    ]
    
    public init() { }
}
