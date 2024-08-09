//
//  GetRecentWeightUsecase.swift
//  Domain
//
//  Created by Happymoonday on 8/8/24.
//

import Foundation

public final class GetRecentWeightUsecase {
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
    }
    
    public func implement() -> WeightDomain? {
        var weights = weightRepository.get()
        weights.sort(by: { $0.date > $1.date })
        return weights.first
    }
}
