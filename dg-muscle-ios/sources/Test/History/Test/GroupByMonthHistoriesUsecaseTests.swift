//
//  GroupByMonthHistoriesUsecaseTests.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import XCTest
import Domain

final class GroupByMonthHistoriesUsecaseTests: XCTestCase {
    func test() {
        let usecase = GroupByMonthHistoriesUsecase()
        let groupedByMonthHistories = usecase.implement(histories: HistoryRepository()._histories)
        
        XCTAssertEqual(groupedByMonthHistories["202405"]?.count, 2)
        XCTAssertEqual(groupedByMonthHistories["202404"]?.count, 1)
    }
}
