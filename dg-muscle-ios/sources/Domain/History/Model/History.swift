//
//  History.swift
//  App
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct History {
    let id: String
    let date: Date
    let memo: String?
    let records: [Record]
    
    var volume: Double {
        records.reduce(0, { $0 + $1.volume })
    }
}
