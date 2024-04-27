//
//  HeatmapV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HeatmapV: Equatable, Identifiable {
    let id: String = UUID().uuidString
    var week: String
    var volumes: [Double]
}
