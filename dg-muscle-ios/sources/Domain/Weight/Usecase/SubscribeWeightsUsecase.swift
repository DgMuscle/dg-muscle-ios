//
//  SubscribeWeightsUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 8/6/24.
//

import Foundation
import Combine

public final class SubscribeWeightsUsecase {
    @Published var weights: [WeightDomain] = []
    
    private let weightRepository: WeightRepository
    private let getWeightsWithoutDuplicatesUsecase: GetWeightsWithoutDuplicatesUsecase
    
    public init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository
        self.getWeightsWithoutDuplicatesUsecase = .init()
        bind()
    }
    
    public func implement() -> AnyPublisher<[WeightDomain], Never> {
        return $weights.eraseToAnyPublisher()
    }
    
    private func bind() {
        weightRepository
            .weights
            .compactMap({ [weak self] weights -> [WeightDomain]? in
                guard let self else { return nil }
                return getWeightsWithoutDuplicatesUsecase.implement(weights: weights)
            })
            .assign(to: &$weights)
    }
}
