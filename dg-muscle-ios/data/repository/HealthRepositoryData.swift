//
//  HealthRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import HealthKit
import Combine

final class HealthRepositoryData: HealthRepositoryDomain {
    static let shared = HealthRepositoryData()
    private let store = HKHealthStore()
    
    var historyMetaDatas: [HistoryMetaDataDomain] { _historyMetaDatas }
    var historyMetaDatasPublisher: AnyPublisher<[HistoryMetaDataDomain], Never> { $_historyMetaDatas.eraseToAnyPublisher() }
    @Published private var _historyMetaDatas: [HistoryMetaDataDomain] = []
    
    var bodyMass: BodyMassDomain? { _bodyMasses.sorted(by: { $0.startDate > $1.startDate }).first }
    private var _bodyMasses: [BodyMassDomain] = []
    
    var heights: [HeightDomain] { _heights }
    var heightsPublisher: AnyPublisher<[HeightDomain], Never> { $_heights.eraseToAnyPublisher() }
    @Published private var _heights: [HeightDomain] = []
    
    var recentHeight: HeightDomain? { heights.sorted(by: { $0.startDate > $1.startDate }).first }
    
    var sex: SexDomain? {
        guard let object: HKBiologicalSexObject = try? store.biologicalSex() else { return nil }
        switch object.biologicalSex {
        case .female:
            return .female
        case .male:
            return .male
        case .notSet, .other:
            return .other
        @unknown default:
            return nil
        }
    }
    
    var birthDateComponents: DateComponents? { try? store.dateOfBirthComponents() }
    
    var bloodType: BloodTypeDomain? {
        guard let object: HKBloodTypeObject = try? store.bloodType() else { return nil }
        switch object.bloodType {
        case .notSet:
            return nil
        case .aPositive:
            return .Ap
        case .aNegative:
            return .An
        case .bPositive:
            return .Bp
        case .bNegative:
            return .Bn
        case .abPositive:
            return .ABp
        case .abNegative:
            return .ABn
        case .oPositive:
            return .Op
        case .oNegative:
            return .On
        @unknown default:
            return nil
        }
    }
    
    private init() {
        _historyMetaDatas = fetchHistoryMetaDatasFromFile()
        
        Task {
            _historyMetaDatas = try await fetchHistoryMetaDatasFromServer()
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
    
    private func fetchHistoryMetaDatasFromFile() -> [HistoryMetaDataDomain] {        
        let data: [HistoryMetaDataData] = (try? FileManagerHelperV2.shared.load([HistoryMetaDataData].self, fromFile: .historyMetaData)) ?? []
        return data.map { $0.domain }
    }
    
    private func fetchHistoryMetaDatasFromServer() async throws -> [HistoryMetaDataDomain] {
        let hkWorkouts = try await fetchHKWorks()
        return generateHistoryMetaDatas(workouts: hkWorkouts)
    }
    
    private func generateHistoryMetaDatas(workouts: [HKWorkout]) -> [HistoryMetaDataDomain] {
        let historyMetaDataDatas: [HistoryMetaDataData] = workouts.filter({ $0.workoutActivityType.rawValue == 50 }).map({ workout in
            let duration = workout.duration
            let startDate = workout.startDate
            let endDate = workout.endDate
            var kcalPerHourKg: Double?
            
            if let averageMet = workout.metadata?[HKMetadataKeyAverageMETs] as? HKQuantity {
                kcalPerHourKg = averageMet.doubleValue(for: .init(from: "kcal/hr·kg"))
            }
            
            return .init(duration: duration, kcalPerHourKg: kcalPerHourKg, startDate: startDate, endDate: endDate)
        })
        
        return historyMetaDataDatas.map { $0.domain }
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
    
    private func fetchMass() async throws -> [BodyMassDomain] {
        let samples = try await fetchSamples(type: HKQuantityType(.bodyMass))
        let quantitySamples = samples.compactMap({ $0 as? HKQuantitySample })
        
        return quantitySamples.map({
            BodyMassDomain(unit: .kg,
                     value: $0.quantity.doubleValue(for: .init(from: "kg")),
                     startDate: $0.startDate)
        })
    }
    
    private func fetchHeight() async throws -> [HeightDomain] {
        let samples = try await fetchSamples(type: HKQuantityType(.height))
        let quantitySamples = samples.compactMap({ $0 as? HKQuantitySample })
        
        return quantitySamples.map({
            HeightDomain(unit: .centi,
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
