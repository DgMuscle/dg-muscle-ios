//
//  GetGroupedHistoriesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

final class GetGroupedHistoriesUsecase {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter
    }()
    
    func implement(histories: [HistoryDomain]) -> [[HistoryDomain]] {
        var group: [[HistoryDomain]] = []
        
        var hashMap: [String: [HistoryDomain]] = [:]
        
        for history in histories {
            let yearMonth = dateFormatter.string(from: history.date)
            hashMap[yearMonth, default: []].append(history)
        }
        
        var keys = hashMap.map({ $0.key })
        
        keys = keys.sorted().reversed()
        
        for key in keys {
            if let histories = hashMap[key] {
                group.append(histories)
            }
        }
        
        return group
    }
}
