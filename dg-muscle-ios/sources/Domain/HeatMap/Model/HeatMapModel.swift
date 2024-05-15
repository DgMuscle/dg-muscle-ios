//
//  HeatMapModel.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct HeatMapModel {
    public let week: String
    public let volume: [Double]
    
    public init(week: String, volume: [Double]) {
        self.week = week
        self.volume = volume
    }
}
