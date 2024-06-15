//
//  History.swift
//  Friend
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Domain

public struct History {
    let id: String
    let date: Date
    let memo: String?
    var records: [ExerciseRecord]
    var volume: Int {
        records.map({ $0.volume }).reduce(0, +)
    }
    
    public init() {
        id = UUID().uuidString
        date = .init()
        memo = nil
        records = []
    }
    
    public init(domain: Domain.History) {
        id = domain.id
        date = domain.date
        memo = domain.memo
        records = domain.records.map({ .init(domain: $0) })
    }
    
    public var domain: Domain.History {
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
