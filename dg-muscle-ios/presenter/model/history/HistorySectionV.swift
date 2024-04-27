//
//  HistorySectionV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HistorySectionV: Identifiable, Equatable {
    let id = UUID().uuidString
    var histories: [HistoryV]
    
    var date: Date {
        let dateString = histories.first?.date ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    var header: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter.string(from: date)
    }
    
    var volume: Double {
        histories.map({ $0.volume }).reduce(0, +)
    }
}
