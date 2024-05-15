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
}