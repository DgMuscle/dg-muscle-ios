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
    @Published var sections: [WeightSection] = []
    
    let getWeightsRangeUsecase: GetWeightsRangeUsecase
    let subscribeWeightsUsecase: SubscribeWeightsUsecase
    let groupWeightsByGroupUsecase: GroupWeightsByGroupUsecase
    
    init(weightRepository: WeightRepository) {
        getWeightsRangeUsecase = .init()
        subscribeWeightsUsecase = .init(weightRepository: weightRepository)
        groupWeightsByGroupUsecase = .init()
        
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
        
        subscribeWeightsUsecase
            .implement()
            .compactMap({ [weak self] weights -> [String: [WeightDomain]]? in
                guard let self else { return nil }
                return groupWeightsByGroupUsecase.implement(weights: weights)
            })
            .map({ $0.map({ WeightSection(yyyyMM: $0.key, weights: $0.value.map({ .init(domain: $0) })) }) })
            .map({ $0.sorted(by: { $0.yyyyMM > $1.yyyyMM }) })
            .receive(on: DispatchQueue.main)
            .assign(to: &$sections)
    }
}
