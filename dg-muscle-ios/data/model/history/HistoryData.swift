//
//  HistoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

struct HistoryData: Codable {
    let id: String
    let date: String
    let memo: String?
    let records: [RecordData]
    
    private var domainDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    init(from: HistoryDomain) {
        id = from.id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        date = dateFormatter.string(from: from.date)
        memo = from.memo
        records = from.records.map({ .init(from: $0) })
    }
    
    var domain: HistoryDomain {
        return .init(id: id, date: domainDate, memo: memo, records: records.map({ $0.domain }))
    }
}
