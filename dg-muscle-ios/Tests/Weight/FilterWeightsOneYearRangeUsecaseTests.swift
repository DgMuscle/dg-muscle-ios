//
//  FilterWeightsOneYearRangeUsecaseTests.swift
//  AppTests
//
//  Created by Donggyu Shin on 8/8/24.
//

import XCTest
import Domain
import MockData

final class FilterWeightsOneYearRangeUsecaseTests: XCTestCase {

    func testExample() throws {
        let usecase = FilterWeightsOneYearRangeUsecase()
        let repository = WeightRepositoryMock()
        let result = usecase.implement(weights: repository.get())
        XCTAssertEqual(WEIGHTS.count - 1, result.count)
    }
}
