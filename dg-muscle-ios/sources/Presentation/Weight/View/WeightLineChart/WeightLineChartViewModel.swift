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
    let weights: [WeightPresentation]
    let range: (Double, Double)
    @Published var selectedDate: Date?
    @Published var selectedWeight: WeightPresentation?
    
    private let searchWeightFromDateUsecase: SearchWeightFromDateUsecase
    
    init(
        weightRepository: WeightRepository,
        weights: [WeightPresentation],
        range: (Double, Double)
    ) {
        searchWeightFromDateUsecase = .init(weightRepository: weightRepository)
        self.weights = weights
        self.range = range
        bind()
    }
    
    private func bind() {        
        $selectedDate
            .compactMap({ $0 })
            .map({ [weak self] date -> WeightPresentation? in
                guard let self else { return nil }
                guard let weight = searchWeightFromDateUsecase.implement(date: date) else { return nil }
                return WeightPresentation(domain: weight)
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$selectedWeight)
    }
}
