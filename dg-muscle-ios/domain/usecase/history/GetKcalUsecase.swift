//
//  GetKcalUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetKcalUsecase {
    let metadata: HistoryMetaDataDomain
    let healthRepository: HealthRepositoryDomain
    
    init(metadata: HistoryMetaDataDomain, healthRepository: HealthRepositoryDomain) {
        self.metadata = metadata
        self.healthRepository = healthRepository
    }
    
    func implement() -> Double? {
        guard let bodyMass = healthRepository.bodyMass else { return nil }
        guard let kcalPerHourKg = metadata.kcalPerHourKg else { return nil }
        guard bodyMass.unit == .kg else { return nil }
        let weight = bodyMass.value
        let duration = metadata.duration
        let hours = duration / 3600
        let kg = weight
        let kcal = kcalPerHourKg * hours * kg
        return kcal
    }
}
