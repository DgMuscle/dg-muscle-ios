//
//  HeatMapModel.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain
import HeatMap

struct HeatMapModel {
    let week: String
    let volume: [Double]
    
    init(domain: Domain.HeatMapData) {
        self.week = domain.week
        self.volume = domain.volume
    }
    
    var domain: Domain.HeatMapData {
        .init(week: week, volume: volume)
    }
    
    var heatMapData: HeatMap.HeatMapData {
        .init(domain: domain)
    }
}
