//
//  HistorySection.swift
//  Common
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Domain
import SwiftUI

public struct HistorySection: Hashable {
    public let id: String
    public let yearMonth: String
    public let histories: [HistoryItem]
    public let yyyyMM: String
    
    public init(
        id: String,
        yearMonth: String,
        histories: [HistoryItem],
        yyyyMM: String
    ) {
        self.id = id
        self.yearMonth = yearMonth
        self.histories = histories
        self.yyyyMM = yyyyMM
    }
    
    public static func configureData(grouped: [String: [Domain.History]], exercises: [Domain.Exercise], color: Color) -> [HistorySection] {
        var data: [HistorySection] = []
        
        let dateFormatter = DateFormatter()
        
        for (month, histories) in grouped {
            let historyList: [Common.HistoryItem] = histories.map({
                .init(
                    history: $0,
                    exercises: exercises,
                    color: color
                )
            })
            dateFormatter.dateFormat = "yyyyMM"
            let date = dateFormatter.date(from: month) ?? Date()
            dateFormatter.dateFormat = "MMM y"
            
            data.append(
                .init(
                    id: UUID().uuidString,
                    yearMonth: dateFormatter.string(from: date),
                    histories: historyList,
                    yyyyMM: month
                )
            )
        }
        
        data.sort(by: { $0.yyyyMM > $1.yyyyMM })
        
        return data
    }
}
