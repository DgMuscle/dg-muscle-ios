//
//  DeleteWeightUsecase.swift
//  Domain
//
//  Created by Happymoonday on 8/13/24.
//

import Foundation

public final class DeleteWeightUsecase {
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
    }
    
    public func implement(weight: WeightDomain) {
        weightRepository.delete(weight: weight)
    }
}
