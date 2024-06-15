//
//  HistorySection.swift
//  Common
//
//  Created by 신동규 on 6/15/24.
//

import Foundation

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
}
