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
    
    private let subscribeWeightsUsecase: SubscribeWeightsUsecase
    private let getWeightsRangeUsecase: GetWeightsRangeUsecase
    
    init(weightRepository: WeightRepository) {
        subscribeWeightsUsecase = .init(weightRepository: weightRepository)
        getWeightsRangeUsecase = .init()
        
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
    }
}
