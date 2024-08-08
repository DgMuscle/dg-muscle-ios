//
//  GetRecentWeightUsecaseTests.swift
//  AppTests
//
//  Created by Happymoonday on 8/8/24.
//

import XCTest
import Domain
import MockData

final class GetRecentWeightUsecaseTests: XCTestCase {
    func testExample() throws {
        let weightRepository: WeightRepository = WeightRepositoryMock()
        let usecase = GetRecentWeightUsecase(weightRepository: weightRepository)
        let result = usecase.implement()
        XCTAssertEqual(result?.value, WEIGHTS.first?.value)
        XCTAssertEqual(result?.date, WEIGHTS.first?.date)
    }

}
