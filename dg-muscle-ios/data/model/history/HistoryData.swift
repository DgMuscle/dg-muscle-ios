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
    
    init(from: HistoryDomain) {
        id = from.id
        date = from.date
        memo = from.memo
        records = from.records.map({ .init(from: $0) })
    }
    
    var domain: HistoryDomain {
        .init(id: id, date: date, memo: memo, records: records.map({ $0.domain }))
    }
}
