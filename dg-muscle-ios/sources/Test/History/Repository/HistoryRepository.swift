//
//  HistoryRepository.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine
import Domain

final class HistoryRepository: Domain.HistoryRepository {
    var histories: AnyPublisher<[History], Never> { $_histories.eraseToAnyPublisher() }
    @Published var _histories: [History] = []
    
    let sets1: [ExerciseSet] = [
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 60),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 60),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 60),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 60),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 60)
    ]
    
    let sets2: [ExerciseSet] = [
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 40),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 40),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 40),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 40),
        .init(id: UUID().uuidString, unit: .kb, reps: 12, weight: 40)
    ]
    
    lazy var record1: ExerciseRecord = .init(id: UUID().uuidString, exerciseId: "squat", sets: sets1)
    lazy var record2: ExerciseRecord = .init(id: UUID().uuidString, exerciseId: "bench press", sets: sets2)
    
    init() {
        prepareHistoriesData()
    }
    
    private func prepareHistoriesData() {
        _histories = [
            createHistory(date: "20240515", memo: nil, records: [record1]),
            createHistory(date: "20240513", memo: nil, records: [record2]),
            createHistory(date: "20240415", memo: nil, records: [record1])
        ]
    }
    
    private func createHistory(date: String, memo: String?, records: [ExerciseRecord]) -> History {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: date)!
        return .init(id: UUID().uuidString, date: date, memo: memo, records: records)
    }
}
