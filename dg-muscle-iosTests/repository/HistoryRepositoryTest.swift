//
//  HistoryRepositoryTest.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HistoryRepositoryTest: HistoryRepository {
    var histories: [HistoryDomain] { _histories }
    var historiesPublisher: AnyPublisher<[HistoryDomain], Never> { $_histories.eraseToAnyPublisher() }
    @Published private var _histories: [HistoryDomain] = []
    
    var heatmapColor: HeatmapColorDomain { _heatmapColor }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { $_heatmapColor.eraseToAnyPublisher() }
    @Published private var _heatmapColor: HeatmapColorDomain = .green
    
    init() {
        prepareMockData()
    }
    
    func post(data: HistoryDomain) async throws {
        _histories.insert(data, at: 0)
    }
    
    func post(data: [HeatmapDomain]) throws {
        
    }
    
    func post(data: HeatmapColorDomain) throws {
        _heatmapColor = data
    }
    
    func delete(data: HistoryDomain) async throws {
        if let index = _histories.firstIndex(where: { $0.id == data.id }) {
            _histories.remove(at: index)
        }
    }
    
    private func prepareMockData() {
        
        let sets: [ExerciseSetDomain] = [
            .init(id: "1", unit: .kg, reps: 10, weight: 75),
            .init(id: "2", unit: .kg, reps: 10, weight: 75),
            .init(id: "3", unit: .kg, reps: 10, weight: 75),
            .init(id: "4", unit: .kg, reps: 10, weight: 75),
            .init(id: "5", unit: .kg, reps: 10, weight: 75),
            .init(id: "6", unit: .kg, reps: 10, weight: 75),
            .init(id: "7", unit: .kg, reps: 10, weight: 75),
        ]
        
        let sets2: [ExerciseSetDomain] = [
            .init(id: "1", unit: .kg, reps: 10, weight: 50),
            .init(id: "2", unit: .kg, reps: 10, weight: 50),
            .init(id: "3", unit: .kg, reps: 10, weight: 50),
            .init(id: "4", unit: .kg, reps: 10, weight: 50),
            .init(id: "5", unit: .kg, reps: 10, weight: 50),
            .init(id: "6", unit: .kg, reps: 10, weight: 50),
            .init(id: "7", unit: .kg, reps: 10, weight: 50),
        ]
        
        let records: [RecordDomain] = [
            .init(id: "1", exerciseId: "squat", sets: sets),
            .init(id: "2", exerciseId: "bench press", sets: sets2),
            .init(id: "3", exerciseId: "pull up", sets: sets),
            .init(id: "4", exerciseId: "leg press", sets: sets),
            .init(id: "5", exerciseId: "arm curl", sets: sets2),
        ]
        
        let records2: [RecordDomain] = [
            .init(id: "1", exerciseId: "squat", sets: sets),
            .init(id: "2", exerciseId: "bench press", sets: sets2),
        ]
        
        _histories = [
            .init(id: "1", date:makeDate(date: "20240101"), memo: "random memo", records: records),
            .init(id: "2", date:makeDate(date: "20240102"), memo: "random memo", records: records2),
            .init(id: "3", date:makeDate(date: "20240103"), memo: "random memo", records: records),
            .init(id: "4", date:makeDate(date: "20240106"), memo: "random memo", records: records2),
            .init(id: "5", date:makeDate(date: "20240110"), memo: "random memo", records: records),
            .init(id: "6", date:makeDate(date: "20240111"), memo: "random memo", records: records),
            .init(id: "7", date:makeDate(date: "20240112"), memo: "random memo", records: records),
            .init(id: "8", date:makeDate(date: "20240201"), memo: "random memo", records: records),
            .init(id: "9", date:makeDate(date: "20240202"), memo: "random memo", records: records),
            .init(id: "10", date:makeDate(date: "20240203"), memo: "random memo", records: records),
            .init(id: "11", date:makeDate(date: "20240301"), memo: "random memo", records: records),
        ]
    }
    
    private func makeDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: date)!
    }
}
