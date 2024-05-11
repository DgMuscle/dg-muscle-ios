//
//  ExerciseRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation
import Combine

protocol ExerciseRepository {
    var exercises: [ExerciseDomain] { get }
    var exercisesPublisher: AnyPublisher<[ExerciseDomain], Never> { get }
    func post(data: ExerciseDomain) async throws
    func edit(data: ExerciseDomain) async throws
    func delete(data: ExerciseDomain) async throws 
    func get(exerciseId: String) -> ExerciseDomain?
    func get(uid: String) async throws -> [ExerciseDomain]
}
