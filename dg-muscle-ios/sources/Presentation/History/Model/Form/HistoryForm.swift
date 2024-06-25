//
//  HistoryForm.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain
import Common

public struct HistoryForm {
    let id: String
    let date: Date
    let memo: String?
    var records: [ExerciseRecord]
    var run: Run?
    var volume: Int {
        records.map({ $0.volume }).reduce(0, +)
    }
    
    public init() {
        id = UUID().uuidString
        date = .init()
        memo = nil
        records = []
        run = nil
    }
    
    public init(domain: Domain.History) {
        id = domain.id
        date = domain.date
        memo = domain.memo
        records = domain.records.map({ .init(domain: $0) })
        if let domain = domain.run {
            run = .init(domain: domain)
        } else {
            run = nil
        }
    }
    
    public var domain: Domain.History {
        .init(
            id: id,
            date: date,
            memo: memo,
            records: records.map({
                $0.domain
            }),
            run: run?.domain
        )
    }
}
