//
//  HistorySection.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct HistorySection: Hashable {
    let id: String
    let yearMonth: String
    let histories: [History]
}
