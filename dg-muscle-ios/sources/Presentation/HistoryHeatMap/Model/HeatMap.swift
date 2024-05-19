//
//  HeatMap.swift
//  Presentation
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public struct HeatMap: Hashable {
    public let week: String
    public let volume: [Volume]
    
    public init(domain: Domain.HeatMap) {
        self.week = domain.week
        self.volume = domain.volume.map({ .init(value: $0) })
    }
    
    public var domain: Domain.HeatMap {
        .init(week: week, volume: volume.map({ $0.value }))
    }
}
