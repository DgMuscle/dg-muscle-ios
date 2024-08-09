//
//  GetWeightsWithoutDuplicatesUsecaseTests.swift
//  AppTests
//
//  Created by Donggyu Shin on 8/6/24.
//

import XCTest
import Domain
import MockData

final class GetWeightsWithoutDuplicatesUsecaseTests: XCTestCase {

    func testNormalCase() throws {
        let usecase = GetWeightsWithoutDuplicatesUsecase()
        let repository = WeightRepositoryMock()
        let result = usecase.implement(weights: repository.get())
        XCTAssertEqual(result.count, repository.get().count - 1)
    }
}
