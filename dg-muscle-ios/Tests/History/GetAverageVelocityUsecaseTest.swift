//
//  GetAverageVelocityUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 7/20/24.
//

import XCTest
import Domain
import MockData

final class GetAverageVelocityUsecaseTest: XCTestCase {

    func testExample() {
        let usecase = GetAverageVelocityUsecase()
        let velocity = usecase.implement(run: RUNS[0])
        XCTAssertEqual(round(velocity), 7)
    }
}
