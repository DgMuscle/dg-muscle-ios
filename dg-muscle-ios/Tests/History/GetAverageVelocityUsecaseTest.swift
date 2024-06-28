//
//  GetAverageVelocityUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 6/28/24.
//

import XCTest
import Domain
import MockData

final class GetAverageVelocityUsecaseTest: XCTestCase {

    func testExample() throws {
        let usecase = GetAverageVelocityUsecase()
        let velocity = usecase.implement(run: HISTORY_1.run!)
        XCTAssertEqual(velocity, 6.7)
    }
}
