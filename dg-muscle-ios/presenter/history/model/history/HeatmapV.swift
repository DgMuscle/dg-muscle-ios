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
    var volumes: [Double]
    
    init(from: HeatmapDomain) {
        id = from.id
        week = from.week
        volumes = from.volumes
    }
    
    var domain: HeatmapDomain {
        .init(id: id, week: week, volumes: volumes)
    }
}
