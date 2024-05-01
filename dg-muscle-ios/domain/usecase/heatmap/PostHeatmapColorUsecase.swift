//
//  PostHeatmapColorUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation

final class PostHeatmapColorUsecase {
    let heatmapRepository: HeatmapRepository
    
    init(heatmapRepository: HeatmapRepository) {
        self.heatmapRepository = heatmapRepository
    }
    
    func implement(data: HeatmapColorDomain) {
        try? heatmapRepository.post(data: data)
    }
}
