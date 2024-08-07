//
//  PostWeightUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation

public final class PostWeightUsecase {
    private let weightRepository: WeightRepository
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
    }
    
    public func implement(weight: WeightDomain) {
        weightRepository.post(weight: weight)
    }
}
