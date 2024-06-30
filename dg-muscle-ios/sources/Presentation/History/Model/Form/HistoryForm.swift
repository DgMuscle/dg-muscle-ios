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
    var memo: [String]
    var records: [ExerciseRecord]
    var run: [RunPresentation]
    var volume: Int {
        records.map({ $0.volume }).reduce(0, +)
    }
    
    public init() {
        id = UUID().uuidString
        date = .init()
        memo = []
        records = []
        run = []
    }
    
    public init(domain: Domain.History) {
        id = domain.id
        date = domain.date
        memo = [domain.memo].compactMap({ $0 })
        records = domain.records.map({ .init(domain: $0) })
        if let domain = domain.run {
            run = [.init(domain: domain)]
        } else {
            run = []
        }
    }
    
    public var domain: Domain.History {
        .init(
            id: id,
            date: date,
            memo: memo.first,
            records: records.map({
                $0.domain
            }),
            run: run.first?.domain
        )
    }
}
