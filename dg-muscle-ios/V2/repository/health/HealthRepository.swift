//
//  HealthRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

protocol HealthRepository {
    var workoutMetaDatas: [WorkoutMetaData] { get }
    var workoutMetaDatasPublisher: AnyPublisher<[WorkoutMetaData], Never> { get }
    var recentBodyMass: BodyMass? { get }
}
