//
//  HeatMap.swift
//  Presentation
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct HeatMap: Hashable {
    let week: String
    let volume: [Volume]
    
    init(domain: Domain.HeatMap) {
        self.week = domain.week
        self.volume = domain.volume.map({ .init(value: $0) })
    }
    
    var domain: Domain.HeatMap {
        .init(week: week, volume: volume.map({ $0.value }))
    }
}
