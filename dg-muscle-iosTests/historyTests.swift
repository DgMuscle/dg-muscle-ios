//
//  historyTests.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/13/24.
//

import XCTest
import Combine

final class historyTests: XCTestCase {
    
    func testSetUpHistorySection() async throws {
        let viewModel = HistoryViewModel(historyRepository: HistoryRepositoryTest(), healthRepository: HealthRepositoryTest())
        
        // I want to check viewModel.historySections after 1 seconds
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        print("viewModel.historySections is \(viewModel.historySections)")
    }
}

extension historyTests {
    final class HistoryRepositoryTest: HistoryRepositoryV2 {
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
            ]
        }
    }
}

extension historyTests {
    final class HealthRepositoryTest: HealthRepository {
        var workoutMetaDatas: [WorkoutMetaData] {
            _workoutMetaDatas
        }
        
        var workoutMetaDatasPublisher: AnyPublisher<[WorkoutMetaData], Never> {
            $_workoutMetaDatas.eraseToAnyPublisher()
        }
        
        @Published var _workoutMetaDatas: [WorkoutMetaData] = []
        
        init() {
            prepareMockData()
        }
        
        private func prepareMockData() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            _workoutMetaDatas = [
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-01 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-02 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-03 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-04 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-07 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-08 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-10 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-20 20:20:00")),
                .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-01 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-21 20:20:00")),
            ]
        }
    }
}
