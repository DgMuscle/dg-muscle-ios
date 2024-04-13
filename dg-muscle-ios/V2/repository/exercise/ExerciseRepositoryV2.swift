//
//  ExerciseRepositoryV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

protocol ExerciseRepositoryV2 {
    var exercises: [Exercise] { get }
    var exercisesPublisher: AnyPublisher<[Exercise], Never> { get }
}
