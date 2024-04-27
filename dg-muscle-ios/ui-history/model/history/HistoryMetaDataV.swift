//
//  HistoryMetaDataV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HistoryMetaDataV: Equatable {
    let duration: TimeInterval
    let kcalPerHourKg: Double?
    let startDate: Date
    let endDate: Date?
    
    init(duration: TimeInterval, kcalPerHourKg: Double?, startDate: Date, endDate: Date?) {
        self.duration = duration
        self.kcalPerHourKg = kcalPerHourKg
        self.startDate = startDate
        self.endDate = endDate
    }
    
    init(from: HistoryMetaDataDomain) {
        self.duration = from.duration
        self.kcalPerHourKg = from.kcalPerHourKg
        self.startDate = from.startDate
        self.endDate = from.endDate
    }
    
    var domain: HistoryMetaDataDomain {
        .init(duration: duration, kcalPerHourKg: kcalPerHourKg, startDate: startDate, endDate: endDate)
    }
}
