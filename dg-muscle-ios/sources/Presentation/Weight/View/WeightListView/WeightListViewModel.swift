//
//  WeightListViewModel.swift
//  App
//
//  Created by Donggyu Shin on 8/7/24.
//

import Foundation
import Combine
import Domain

final class WeightListViewModel: ObservableObject {
    @Published var weightRange: (Double, Double) = (0, 0)
    @Published var weights: [WeightPresentation] = []
    
    let getWeightsRangeUsecase: GetWeightsRangeUsecase
    let subscribeWeightsUsecase: SubscribeWeightsUsecase
    
    init(weightRepository: WeightRepository) {
        getWeightsRangeUsecase = .init()
        subscribeWeightsUsecase = .init(weightRepository: weightRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeWeightsUsecase
            .implement()
            .map({ weights -> [WeightPresentation] in
                weights.map({ .init(domain: $0) })
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$weights)
        
        subscribeWeightsUsecase
            .implement()
            .compactMap({ [weak self] weights -> (Double, Double)? in
                guard let self else { return nil }
                return getWeightsRangeUsecase.implement(weights: weights)
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$weightRange)
    }
}
