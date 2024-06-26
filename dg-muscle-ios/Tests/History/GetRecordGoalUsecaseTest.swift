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
        let previousRecord = RECORD_4
        let usecase = GetRecordGoalUsecase()
        
        /// when
        let recommendedSet = usecase.implement(previousRecord: previousRecord)
        
        /// then
        XCTAssertEqual(recommendedSet?.weight, 70)
        XCTAssertEqual(recommendedSet?.reps, 10)
    }
}
