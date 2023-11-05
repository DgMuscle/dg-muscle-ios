//
//  HealthStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/4/23.
//

import Foundation
import Combine
import HealthKit

final class HealthStore: ObservableObject {
    static let shared = HealthStore()
    
    private let store = HKHealthStore()
    private let workoutType = HKObjectType.workoutType()
    private let sexType = HKCharacteristicType(.biologicalSex)
    private let birthType = HKCharacteristicType(.dateOfBirth)
    private let bloodTypeType = HKCharacteristicType(.bloodType)
    
    private let heightType = HKQuantityType(.height)
    private let bodyMassType = HKQuantityType(.bodyMass)
    
    @Published private(set) var workoutMetaDatas: [WorkoutMetaData] = []
    @Published private(set) var heights: [Height] = []
    @Published private(set) var bodyMasses: [BodyMass] = []
    @Published private(set) var sex: HKBiologicalSex?
    @Published private(set) var birthDateComponents: DateComponents?
    @Published private(set) var bloodType: HKBloodType?
    
    private init() { }
    
    func requestAuthorization() async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            store.requestAuthorization(toShare: nil, read: [
                workoutType,
                sexType,
                birthType,
                bloodTypeType,
                heightType,
                bodyMassType
            ]) { success, error in
                if success {
                    continuation.resume()
                } else if let error {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetch() {
        Task {
            async let workoutsAsync = fetchHKWorks()
            async let heightsAsync = fetchHeight()
            async let bodyMassesAsync = fetchMass()
            
            let (workouts, heights, bodyMasses) = try await (workoutsAsync, heightsAsync, bodyMassesAsync)
            
            let metadatas = generateWorkoutMetaDatas(workouts: workouts)
            let sex = try store.biologicalSex()
            let date = try store.dateOfBirthComponents()
            let bloodType = try store.bloodType()
            
            DispatchQueue.main.async {
                self.workoutMetaDatas = metadatas
                self.heights = heights
                self.bodyMasses = bodyMasses
                self.sex = sex.biologicalSex
                self.birthDateComponents = date
                self.bloodType = bloodType.bloodType
            }
        }
    }
    
    private func fetchHKWorks() async throws -> [HKWorkout] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: workoutType,
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
    
    private func generateWorkoutMetaDatas(workouts: [HKWorkout]) -> [WorkoutMetaData] {
        workouts.filter({ $0.workoutActivityType.rawValue == 50 }).map({ workout in
            let duration = workout.duration
            let startDate = workout.startDate
            let endDate = workout.endDate
            var kcalPerHourKg: Double?
            
            if let averageMet = workout.metadata?[HKMetadataKeyAverageMETs] as? HKQuantity {
                kcalPerHourKg = averageMet.doubleValue(for: .init(from: "kcal/hr·kg"))
            }
            
            return .init(duration: duration, kcalPerHourKg: kcalPerHourKg, startDate: startDate, endDate: endDate)
        })
    }
    
    private func fetchMass() async throws -> [BodyMass] {
        let samples = try await fetchSamples(type: bodyMassType)
        let quantitySamples = samples.compactMap({ $0 as? HKQuantitySample })
        
        return quantitySamples.map({
            BodyMass(unit: .kg,
                     value: $0.quantity.doubleValue(for: .init(from: "kg")),
                     startDate: $0.startDate)
        })
    }
    
    private func fetchHeight() async throws -> [Height] {
        let samples = try await fetchSamples(type: heightType)
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
                } else if let result {
                    continuation.resume(returning: result)
                }
            })
            store.execute(query)
        }
    }
}
