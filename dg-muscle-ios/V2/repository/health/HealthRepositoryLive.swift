//
//  HealthRepositoryLive.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import Combine
import HealthKit

final class HealthRepositoryLive: HealthRepository {
    static let shared = HealthRepositoryLive()
    
    var workoutMetaDatas: [WorkoutMetaData] { _workoutMetaDatas }
    
    var workoutMetaDatasPublisher: AnyPublisher<[WorkoutMetaData], Never> {
        $_workoutMetaDatas.eraseToAnyPublisher()
    }
    
    var recentBodyMass: BodyMass? { _bodyMasses.sorted(by: { $0.startDate > $1.startDate }).first }
    
    var heights: [Height] { _heights }
    
    var heightsPublisher: AnyPublisher<[Height], Never> {
        $_heights.eraseToAnyPublisher()
    }
    
    var recentHeight: Height? {
        heights.sorted(by: { $0.startDate > $1.startDate }).first
    }
    
    @Published private var _workoutMetaDatas: [WorkoutMetaData] = []
    @Published private var _heights: [Height] = []
    
    private var _bodyMasses: [BodyMass] = []
    
    private let store = HKHealthStore()
    
    private init() {
        // Load datas from file manager
        _workoutMetaDatas = fetchWorkoutMetaDatasFromFile()
        
        // Load datas from server
        Task {
            _workoutMetaDatas = try await fetchWorkoutMetaDatasFromServer()
        }
        
        Task {
            _bodyMasses = try await fetchMass()
        }
        
        Task {
            _heights = try await fetchHeight()
        }
        
        Task {
            try await requestAuthorization()
        }
    }
    
    private func fetchWorkoutMetaDatasFromFile() -> [WorkoutMetaData] {
        (try? FileManagerHelper.load([WorkoutMetaData].self, fromFile: .workoutMetaData)) ?? []
    }
    
    private func fetchWorkoutMetaDatasFromServer() async throws -> [WorkoutMetaData] {
        let hkWorkouts = try await fetchHKWorks()
        return generateWorkoutMetaDatas(workouts: hkWorkouts)
    }
    
    // O(n)
    private func generateWorkoutMetaDatas(workouts: [HKWorkout]) -> [WorkoutMetaData] {
        let workoutMetaDatas: [WorkoutMetaData] = workouts.filter({ $0.workoutActivityType.rawValue == 50 }).map({ workout in
            let duration = workout.duration
            let startDate = workout.startDate
            let endDate = workout.endDate
            var kcalPerHourKg: Double?
            
            if let averageMet = workout.metadata?[HKMetadataKeyAverageMETs] as? HKQuantity {
                kcalPerHourKg = averageMet.doubleValue(for: .init(from: "kcal/hr·kg"))
            }
            
            return .init(duration: duration, kcalPerHourKg: kcalPerHourKg, startDate: startDate, endDate: endDate)
        })
        
        do {
            try? FileManagerHelper.save(workoutMetaDatas, toFile: .workoutMetaData)
        }
        
        return workoutMetaDatas
    }
    
    private func fetchHKWorks() async throws -> [HKWorkout] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: HKObjectType.workoutType(),
                                      predicate: nil,
                                      limit: 0,
                                      sortDescriptors: []) { (_, results, error) -> Void in
                
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: results as? [HKWorkout] ?? [])
                }
            }
            store.execute(query)
        }
    }
    
    private func fetchMass() async throws -> [BodyMass] {
        let samples = try await fetchSamples(type: HKQuantityType(.bodyMass))
        let quantitySamples = samples.compactMap({ $0 as? HKQuantitySample })
        
        return quantitySamples.map({
            BodyMass(unit: .kg,
                     value: $0.quantity.doubleValue(for: .init(from: "kg")),
                     startDate: $0.startDate)
        })
    }
    
    private func fetchHeight() async throws -> [Height] {
        let samples = try await fetchSamples(type: HKQuantityType(.height))
        let quantitySamples = samples.compactMap({ $0 as? HKQuantitySample })
        
        return quantitySamples.map({
            Height(unit: .centi,
                   value: $0.quantity.doubleValue(for: .meterUnit(with: .centi)),
                   startDate: $0.startDate)
        })
    }
    
    private func fetchSamples(type: HKSampleType) async throws -> [HKSample] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: type, predicate: nil, limit: 10, sortDescriptors: nil, resultsHandler: {(query, result, error)in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: result ?? [])
                }
            })
            store.execute(query)
        }
    }
    
    private func requestAuthorization() async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            store.requestAuthorization(toShare: nil, read: [
                HKObjectType.workoutType(),
                HKCharacteristicType(.biologicalSex),
                HKCharacteristicType(.dateOfBirth),
                HKCharacteristicType(.bloodType),
                HKQuantityType(.height),
                HKQuantityType(.bodyMass)
            ]) { success, error in
                if success {
                    continuation.resume()
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
