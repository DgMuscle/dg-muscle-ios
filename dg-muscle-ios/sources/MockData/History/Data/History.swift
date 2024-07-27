//
//  History.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public var HISTORIES: [Domain.History] {
    
    if let filePath = Bundle(for: ForBundle.self).url(forResource: "histories", withExtension: "json") {
        if let data = try? Data(contentsOf: filePath) {
            let decoder = JSONDecoder()
            if let history: [HistoryMockData] = try? decoder.decode([HistoryMockData].self, from: data) {
                return history.map({ $0.domain })
            }
        }
    }
    
    return []
}

public var RUNS: [Domain.Run] {
    return HISTORIES.compactMap({ $0.run })
}

private class ForBundle { }
