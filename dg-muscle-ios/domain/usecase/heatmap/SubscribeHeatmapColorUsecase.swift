//
//  SubscribeHeatmapColorUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class SubscribeHeatmapColorUsecase {
    private let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement() -> AnyPublisher<HeatmapColorDomain, Never> {
        historyRepository.heatmapColorPublisher
    }
}
