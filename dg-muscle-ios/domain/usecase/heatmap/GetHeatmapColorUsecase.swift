//
//  GetHeatmapColorUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation

final class GetHeatmapColorUsecase {
    let heatMapRepository: HeatmapRepository
    
    init(heatMapRepository: HeatmapRepository) {
        self.heatMapRepository = heatMapRepository
    }
    
    func implement() -> HeatmapColorDomain {
        heatMapRepository.heatmapColor
    }
}
