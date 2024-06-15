//
//  ExerciseRepository.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine

public protocol ExerciseRepository {
    var exercises: AnyPublisher<[Exercise], Never> { get }
    
    func get() -> [Exercise]
    func post(_ exercise: Exercise) async throws
    func delete(_ exercise: Exercise) async throws
}
