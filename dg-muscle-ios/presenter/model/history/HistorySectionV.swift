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
        histories.first?.date ?? Date()
    }
    
    var header: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM y"
        return dateFormatter.string(from: date)
    }
    
    var volume: Double {
        histories.map({ $0.volume }).reduce(0, +)
    }
}