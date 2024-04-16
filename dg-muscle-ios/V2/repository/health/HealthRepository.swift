//
//  HealthRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import HealthKit
import Foundation

protocol HealthRepository {
    var workoutMetaDatas: [WorkoutMetaData] { get }
    var workoutMetaDatasPublisher: AnyPublisher<[WorkoutMetaData], Never> { get }
    var recentBodyMass: BodyMass? { get }
    var heights: [Height] { get }
    var heightsPublisher: AnyPublisher<[Height], Never> { get }
    var recentHeight: Height? { get }
    var sex: HKBiologicalSexObject? { get }
    var birthDateComponents: DateComponents? { get }
    var bloodType: HKBloodTypeObject? { get }
}
