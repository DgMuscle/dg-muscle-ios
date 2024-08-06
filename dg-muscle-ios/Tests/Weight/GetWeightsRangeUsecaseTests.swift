//
//  GetWeightsRangeUsecaseTests.swift
//  AppTests
//
//  Created by Donggyu Shin on 8/6/24.
//

import XCTest
import Domain
import MockData

final class GetWeightsRangeUsecaseTests: XCTestCase {

    func testExample() throws {
        let usecase = GetWeightsRangeUsecase()
        let repository: WeightRepository = WeightRepositoryMock()
        let result = usecase.implement(weights: repository.get())
        XCTAssertEqual(result.0, 57)
        XCTAssertEqual(result.1, 73)
    }
}
