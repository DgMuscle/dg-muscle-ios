//
//  SubscribeHeatmapColorUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class SubscribeHeatmapColorUsecase {
    private let heatmapRepository: HeatmapRepository
    
    init(heatmapRepository: HeatmapRepository) {
        self.heatmapRepository = heatmapRepository
    }
    
    func implement() -> AnyPublisher<HeatmapColorDomain, Never> {
        heatmapRepository.heatmapColorPublisher
    }
}
