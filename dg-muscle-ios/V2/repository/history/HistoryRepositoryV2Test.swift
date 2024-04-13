//
//  HistoryRepositoryV2Test.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine

final class HistoryRepositoryV2Test: HistoryRepositoryV2 {
    var histories: [ExerciseHistory] {
        _histories
    }
    
    var historiesPublisher: AnyPublisher<[ExerciseHistory], Never> {
        $_histories.eraseToAnyPublisher()
    }
    
    @Published var _histories: [ExerciseHistory] = []
    
    init() {
        prepareMockData()
    }
    
    private func prepareMockData() {
        
        let sets: [ExerciseSet] = [
            .init(unit: .kg, reps: 10, weight: 75, id: "1"),
            .init(unit: .kg, reps: 10, weight: 75, id: "2"),
            .init(unit: .kg, reps: 10, weight: 75, id: "3"),
            .init(unit: .kg, reps: 10, weight: 75, id: "4"),
            .init(unit: .kg, reps: 10, weight: 75, id: "5"),
            .init(unit: .kg, reps: 10, weight: 75, id: "6"),
            .init(unit: .kg, reps: 10, weight: 75, id: "7"),
        ]
        
        let records: [Record] = [
            .init(id: "1", exerciseId: "squat", sets: sets)
        ]
        
        _histories = [
            .init(id: "1", date: "20240101", memo: "random memo", records: records, createdAt: nil),
            .init(id: "2", date: "20240102", memo: "random memo", records: records, createdAt: nil),
            .init(id: "3", date: "20240103", memo: "random memo", records: records, createdAt: nil),
            .init(id: "4", date: "20240106", memo: "random memo", records: records, createdAt: nil),
            .init(id: "5", date: "20240110", memo: "random memo", records: records, createdAt: nil),
            .init(id: "6", date: "20240111", memo: "random memo", records: records, createdAt: nil),
            .init(id: "7", date: "20240112", memo: "random memo", records: records, createdAt: nil),
            .init(id: "8", date: "20240201", memo: "random memo", records: records, createdAt: nil),
            .init(id: "9", date: "20240202", memo: "random memo", records: records, createdAt: nil),
            .init(id: "10", date: "20240203", memo: "random memo", records: records, createdAt: nil),
            .init(id: "11", date: "20240301", memo: "random memo", records: records, createdAt: nil),
        ]
    }
}
