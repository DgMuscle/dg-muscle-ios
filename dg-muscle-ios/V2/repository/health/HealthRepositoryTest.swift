//
//  HealthRepositoryTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import Foundation
import HealthKit

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
    
    var heights: [Height] { _heights }
    
    var heightsPublisher: AnyPublisher<[Height], Never> {
        $_heights.eraseToAnyPublisher()
    }
    
    var recentHeight: Height? {
        heights.sorted(by: { $0.startDate > $1.startDate }).first
    }
    
    var sex: HKBiologicalSexObject? {
        let sex = HKBiologicalSexObject()
        return sex
    }
    var birthDateComponents: DateComponents? {
        var dateComponents = DateComponents()
        dateComponents.year = 1994
        dateComponents.month = 10
        dateComponents.day = 13
        return dateComponents
    }
    var bloodType: HKBloodTypeObject? {
        HKBloodTypeObject()
    }
    
    @Published private var _workoutMetaDatas: [WorkoutMetaData] = []
    @Published private var _heights: [Height] = [.init(unit: .centi, value: 171.2, startDate: Date())]
    
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
