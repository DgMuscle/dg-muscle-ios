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
            fetchWeights()
        }
    }
    
    public func get() -> [Domain.WeightDomain] {
        _weights
    }
    
    private func fetchWeights() {
        
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
}
