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
        var today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: "20240727") {
            today = date
        }
        
        return GetHeatMapUsecase(today: today).implement(histories: HISTORIES)
    }
    
    public func post(heatMap: [Domain.HeatMap]) { }
    
    public func get() throws -> Domain.HeatMapColor {
        return .blue
    }
}
