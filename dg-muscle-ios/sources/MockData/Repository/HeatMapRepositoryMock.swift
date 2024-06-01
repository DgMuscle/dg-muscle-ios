//
//  HeatMapRepositoryMock.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public final class HeatMapRepositoryMock: HeatMapRepository {
    public init() { }
    public func get() -> [Domain.HeatMap] {
        []
    }
    
    public func post(heatMap: [Domain.HeatMap]) { }
}
