//
//  WeightRepositoryImpl.swift
//  App
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Combine
import Domain
import HealthKit

public final class WeightRepositoryImpl: WeightRepository {
    public static let shared = WeightRepositoryImpl()
    
    private let healthStore = HKHealthStore()
    private let allTypes = Set([HKObjectType.quantityType(forIdentifier: .bodyMass)!])

    public var weights: AnyPublisher<[Domain.WeightDomain], Never> { $_weights.eraseToAnyPublisher() }
    @Published var _weights: [Domain.WeightDomain] = []
    
    private init() {
        Task {
            try await requestPermission()
            _weights = try await getWeights()
        }
    }
    
    public func get() -> [Domain.WeightDomain] {
        _weights
    }
    
    public func post(weight: Domain.WeightDomain) {
        guard let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) else {
            print("Weight type is no longer available in HealthKit")
            return
        }

        let weightQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: weight.value)
        let weightSample = HKQuantitySample(type: weightType, quantity: weightQuantity, start: weight.date, end: weight.date)

        healthStore.save(weightSample) { (success, error) in
            if let error = error {
                print("Error saving weight sample: \(error.localizedDescription)")
            } else {
                self._weights.append(weight)
            }
        }
    }
    
    private func requestPermission() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    private func fetchWeightSamples(completion: @escaping ([HKQuantitySample]?, Error?) -> Void) {
        guard let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            completion(nil, nil)
            return
        }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            guard let samples = samples as? [HKQuantitySample] else {
                completion(nil, error)
                return
            }

            completion(samples, nil)
        }

        healthStore.execute(query)
    }
    
    private func fetchWeights() async throws -> [HKQuantitySample] {
        return try await withCheckedThrowingContinuation { continuation in
            fetchWeightSamples { samples, error in
                if let samples {
                    continuation.resume(returning: samples)
                } else {
                    continuation.resume(throwing: error ?? DataError.unknown)
                }
            }
        }
    }
    
    private func convertSampleToWeight(sample: HKQuantitySample) -> Domain.WeightDomain {
        var result: Domain.WeightDomain
        
        let value = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
        let date = sample.startDate
        
        result = .init(value: value, unit: .kg, date: date)
        
        return result
    }
    
    private func getWeights() async throws -> [Domain.WeightDomain] {
        let samples = try await fetchWeights()
        return samples.map({ convertSampleToWeight(sample: $0) })
    }
}
