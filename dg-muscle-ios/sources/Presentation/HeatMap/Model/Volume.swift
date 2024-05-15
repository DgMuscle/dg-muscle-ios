//
//  Volume.swift
//  HeatMap
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct Volume: Hashable {
    let id: String = UUID().uuidString
    let value: Double
}
