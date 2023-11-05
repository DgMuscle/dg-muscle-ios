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
    private let read: HKWorkoutType = HKObjectType.workoutType()
    
    @Published private(set) var workoutMetaDatas: [WorkoutMetaData] = []
    
    private init() { }
    
    func requestAuthorization() async throws {
        
        return try await withCheckedThrowingContinuation { continuation in
            store.requestAuthorization(toShare: nil, read: [read]) { success, error in
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
            let workouts = try await fetchHKWorks()
            let metadatas = generateWorkoutMetaDatas(workouts: workouts)
            
            DispatchQueue.main.async {
                self.workoutMetaDatas = metadatas
            }
        }
    }
    
    private func fetchHKWorks() async throws -> [HKWorkout] {
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(sampleType: read,
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
}
