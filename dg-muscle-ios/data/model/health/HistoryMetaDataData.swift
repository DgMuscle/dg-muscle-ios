//
//  HistoryMetaDataData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HistoryMetaDataData: Codable {
    let duration: TimeInterval
    let kcalPerHourKg: Double?
    let startDate: Date
    let endDate: Date?
    
    init(from: HistoryMetaDataDomain) {
        duration = from.duration
        kcalPerHourKg = from.kcalPerHourKg
        startDate = from.startDate
        endDate = from.endDate
    }
    
    init(
        duration: TimeInterval,
        kcalPerHourKg: Double?,
        startDate: Date,
        endDate: Date?
    ) {
        self.duration = duration
        self.kcalPerHourKg = kcalPerHourKg
        self.startDate = startDate
        self.endDate = endDate
    }
    
    var domain: HistoryMetaDataDomain {
        .init(duration: duration, kcalPerHourKg: kcalPerHourKg, startDate: startDate, endDate: endDate)
    }
}
