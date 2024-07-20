//
//  GroupByMonthHistoriesUsecaseTest.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import XCTest
import MockData
import Domain

final class GroupByMonthHistoriesUsecaseTest: XCTestCase {
    func testImplement() {
        
        let usecase = GroupByMonthHistoriesUsecase()
        let groupedByMonthHistories = usecase.implement(histories: HISTORIES)
        
        XCTAssertEqual(groupedByMonthHistories["202405"]?.count, 15)
        XCTAssertEqual(groupedByMonthHistories["202404"]?.count, 10)
    }
}
