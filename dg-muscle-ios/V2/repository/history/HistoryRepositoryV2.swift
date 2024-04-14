//
//  HistoryRepositoryV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

protocol HistoryRepositoryV2 {
    var histories: [ExerciseHistory] { get }
    var historiesPublisher: AnyPublisher<[ExerciseHistory], Never> { get }
    func post(data: ExerciseHistory) async throws -> DefaultResponse
}
