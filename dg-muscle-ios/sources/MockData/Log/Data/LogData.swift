//
//  LogData.swift
//  MockData
//
//  Created by 신동규 on 7/27/24.
//

import Foundation
import Domain

public var LOGS: [Domain.DGLog] {
    var result: [Domain.DGLog] = []
    
    if let filePath = Bundle(for: ForBundle.self).url(forResource: "all_logs_response", withExtension: "json") {
        if let data = try? Data(contentsOf: filePath) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([DgLogMockData].self, from: data) {
                result = decoded.map({ $0.domain })
            }
        }
    }
    
    return result
}

private class ForBundle { }
