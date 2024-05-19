//
//  HeatMap.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct HeatMap: Codable {
    let week: String
    let volume: [Double]
    
    init(domain: Domain.HeatMapModel) {
        self.week = domain.week
        self.volume = domain.volume
    }
    
    var domain: Domain.HeatMapModel {
        .init(week: week, volume: volume)
    }
}
