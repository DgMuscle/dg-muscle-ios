//
//  RapidRepository.swift
//  Domain
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Combine

public protocol RapidRepository {
    var exercises: AnyPublisher<[RapidExerciseDomain], Never> { get }
    var exercisesLoading: AnyPublisher<Bool, Never> { get }
    func get() -> [RapidExerciseDomain]
}
