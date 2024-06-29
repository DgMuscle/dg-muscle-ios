//
//  History.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

struct History: Codable {
    let id: String
    let date: String
    let memo: String?
    let records: [ExerciseRecord]
    let runV2: Run?
    
    static private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    init(domain: Domain.History) {
        self.id = domain.id
        self.date = Self.dateFormatter.string(from: domain.date)
        self.memo = domain.memo
        self.records = domain.records.map({ .init(domain: $0) })
        if let domain = domain.run {
            self.runV2 = .init(domain: domain)
        } else {
            self.runV2 = nil
        }
        
    }
    
    var domain: Domain.History {
        .init(
            id: id,
            date: Self.dateFormatter.date(
                from: date
            )!,
            memo: memo,
            records: records.map({
                $0.domain
            }),
            run: runV2?.domain
        )
    }
}
