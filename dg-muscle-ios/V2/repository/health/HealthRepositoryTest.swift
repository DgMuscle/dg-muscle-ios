//
//  HealthRepositoryTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation

final class HealthRepositoryTest: HealthRepository {
    var workoutMetaDatas: [WorkoutMetaData] {
        _workoutMetaDatas
    }
    
    var workoutMetaDatasPublisher: AnyPublisher<[WorkoutMetaData], Never> {
        $_workoutMetaDatas.eraseToAnyPublisher()
    }
    
    var recentBodyMass: BodyMass? {
        BodyMass(unit: .kg, value: 69, startDate: Date())
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
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-02 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-02 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-03 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-03 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-04 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-04 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-07 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-07 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-08 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-08 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-10 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-10 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-20 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-20 20:20:00")),
            .init(duration: 100, kcalPerHourKg: 100, startDate: dateFormatter.date(from: "2024-01-21 20:00:00")!, endDate: dateFormatter.date(from: "2024-01-21 20:20:00")),
        ]
    }
}
