//
//  History.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

public struct History {
    public let id: String
    public let date: Date
    public let memo: String?
    public let records: [ExerciseRecord]
    
    public init(id: String, date: Date, memo: String?, records: [ExerciseRecord]) {
        self.id = id
        self.date = date
        self.memo = memo
        self.records = records
    }
    
    public var volume: Double {
        records.reduce(0, { $0 + $1.volume })
    }
}
