//
//  HeatmapData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct HeatmapData: Codable {
    let id: String
    let week: String
    let volumes: [Double]
    
    init(from: HeatmapDomain) {
        id = from.id
        week = from.week
        volumes = from.volumes
    }
    
    var domain: HeatmapDomain {
        .init(id: id, week: week, volumes: volumes)
    }
}
