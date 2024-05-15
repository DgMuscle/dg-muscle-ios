//
//  HeatMapRepository.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public protocol HeatMapRepository {
    func get() -> [HeatMap]
    func post(heatMap: [HeatMap])
}
