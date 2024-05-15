//
//  GroupByMonthHistoriesUsecaseTests.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import XCTest
import MockData
import Domain

final class GroupByMonthHistoriesUsecaseTests: XCTestCase {
    func test() {
        let usecase = GroupByMonthHistoriesUsecase()
        let groupedByMonthHistories = usecase.implement(histories: [
            HISTORY_1, HISTORY_2, HISTORY_3
        ])
        
        XCTAssertEqual(groupedByMonthHistories["202405"]?.count, 2)
        XCTAssertEqual(groupedByMonthHistories["202404"]?.count, 1)
    }
}
