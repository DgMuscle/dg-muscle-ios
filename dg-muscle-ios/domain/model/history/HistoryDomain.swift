//
//  History.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct HistoryDomain {
    let id: String
    let date: Date
    let memo: String?
    let records: [RecordDomain]
    
    var volume: Double {
        records.map({ $0.volume }).reduce(0, +)
    }
}
