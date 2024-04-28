//
//  HistoryV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

struct HistoryV: Equatable, Identifiable {
    let id: String
    let date: String
    let memo: String?
    let records: [RecordV]
    var metaData: HistoryMetaDataV?
    
    private let dateBackup: Date
    
    init(from: HistoryDomain) {
        id = from.id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        date = dateFormatter.string(from: from.date)
        dateBackup = from.date
        memo = from.memo
        records = from.records.map({ .init(from: $0) })
    }
    
    var domain: HistoryDomain {
        .init(id: id, date: dateBackup, memo: memo, records: records.map({ $0.domain }))
    }
    
    var volume: Double {
        records.reduce(0, { $0 + $1.volume })
    }
}
