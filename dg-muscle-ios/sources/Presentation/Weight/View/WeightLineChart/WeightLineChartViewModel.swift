//
//  WeightLineChartViewModel.swift
//  Weight
//
//  Created by 신동규 on 8/6/24.
//

import Foundation
import Combine
import Domain

final class WeightLineChartViewModel: ObservableObject {
    @Published var weights: [WeightPresentation] = []
    @Published var range: (Double, Double) = (0, 0)
    @Published var selectedDate: Date? 
    @Published var selectedWeight: WeightPresentation?
    
    private let subscribeWeightsUsecase: SubscribeWeightsUsecase
    private let getWeightsRangeUsecase: GetWeightsRangeUsecase
    private let searchWeightFromDateUsecase: SearchWeightFromDateUsecase
    
    init(weightRepository: WeightRepository) {
        subscribeWeightsUsecase = .init(weightRepository: weightRepository)
        getWeightsRangeUsecase = .init()
        searchWeightFromDateUsecase = .init(weightRepository: weightRepository)
        
        bind()
    }
    
    private func bind() {
        subscribeWeightsUsecase
            .implement()
            .compactMap({ weightDomains -> [WeightPresentation] in
                weightDomains.map({ .init(domain: $0) })
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$weights)
        
        subscribeWeightsUsecase
            .implement()
            .compactMap({ [weak self] weights -> (Double, Double)? in
                guard let self else { return nil }
                return getWeightsRangeUsecase.implement(weights: weights)
            })
            .assign(to: &$range)
        
        $selectedDate
            .compactMap({ $0 })
            .map({ [weak self] date -> WeightPresentation? in
                guard let self else { return nil }
                guard let weight = searchWeightFromDateUsecase.implement(date: date) else { return nil }
                return WeightPresentation(domain: weight)
            })
            .assign(to: &$selectedWeight)
    }
}
