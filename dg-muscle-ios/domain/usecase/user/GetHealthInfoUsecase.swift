//
//  GetHealthInfoUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetHealthInfoUsecase {
    let healthRepository: HealthRepositoryDomain
    
    init(healthRepository: HealthRepositoryDomain) {
        self.healthRepository = healthRepository
    }
    
    func implement() -> (BodyMassDomain?, DateComponents?, BloodTypeDomain?, HeightDomain?, SexDomain?) {
        let bodyMass = healthRepository.bodyMass
        let birthDateComponents = healthRepository.birthDateComponents
        let bloodType = healthRepository.bloodType
        let heights = healthRepository.recentHeight
        let sex = healthRepository.sex
        return (bodyMass, birthDateComponents, bloodType, heights, sex)
    }
}
