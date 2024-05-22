//
//  HistoryForm.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

struct HistoryForm {
    let id: String
    let date: Date
    let memo: String?
    let records: [ExerciseRecord]
    
    init() {
        id = UUID().uuidString
        date = .init()
        memo = nil
        records = []
    }
    
    init(domain: Domain.History) {
        id = domain.id
        date = domain.date
        memo = domain.memo
        records = domain.records.map({ .init(domain: $0) })
    }
    
    var domain: Domain.History {
        .init(
            id: id,
            date: date,
            memo: memo,
            records: records.map({
                $0.domain
            })
        )
    }
}
