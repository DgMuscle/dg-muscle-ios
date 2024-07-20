//
//  GetRecordGoalUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 6/26/24.
//

import XCTest
import Domain
import MockData

final class GetRecordGoalUsecaseTest: XCTestCase {

    func testExample() throws {
        /// given
        let previousRecord = historiesFromJsonResponse[0].records[0]
        let usecase = GetRecordGoalUsecase()
        
        /// when
        let recommendedSet = usecase.implement(previousRecord: previousRecord)
        
        /// then
        XCTAssertEqual(recommendedSet?.weight, 45)
        XCTAssertEqual(recommendedSet?.reps, 14)
    }
}
