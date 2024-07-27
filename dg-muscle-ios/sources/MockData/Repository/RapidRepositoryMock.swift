//
//  RapidRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain
import Combine

public final class RapidRepositoryMock: RapidRepository {
    public var exercisesLoading: AnyPublisher<Bool, Never> {
        $_exercisesLoading.eraseToAnyPublisher()
    }
    
    @Published var _exercisesLoading: Bool = true
    
    public var exercises: AnyPublisher<[Domain.RapidExerciseDomain], Never> {
        $_exercises.eraseToAnyPublisher()
    }
    
    @Published var _exercises: [Domain.RapidExerciseDomain] = []
    
    public init() {
        _exercises = RAPID_EXERCISES
    }
    
    public func get() -> [RapidExerciseDomain] {
        RAPID_EXERCISES
    }
}
