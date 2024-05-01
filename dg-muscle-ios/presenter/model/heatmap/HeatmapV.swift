//
//  HeatmapV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HeatmapV: Equatable, Identifiable {
    let id: String
    var week: String
    var volumes: [Volume]
    
    init(from: HeatmapDomain) {
        id = from.id
        week = from.week
        volumes = from.volumes.map({ .init(value: $0) })
    }
    
    var domain: HeatmapDomain {
        .init(id: id, week: week, volumes: volumes.map({ $0.value }))
    }
}

extension HeatmapV {
    struct Volume: Equatable, Identifiable {
        let id: String = UUID().uuidString
        let value: Double
    }
}
