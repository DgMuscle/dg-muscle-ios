//
//  GroupByMonthHistoriesUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

final class GroupByMonthHistoriesUsecase {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter
    }()
    
    /// O(n)
    func implement(histories: [History]) -> [String: [History]] {
        /// sort
        /// O(n)
        let histories = histories.sorted(by: { $0.date > $1.date })
        
        var group: [String:[History]] = [:]
        
        /// set
        /// O(n)
        for history in histories {
            let month = dateFormatter.string(from: history.date)
            group[month, default: []].append(history)
        }
        
        return group
    }
}
