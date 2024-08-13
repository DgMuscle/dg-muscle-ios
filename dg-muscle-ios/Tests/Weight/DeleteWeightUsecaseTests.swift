//
//  DeleteWeightUsecaseTests.swift
//  AppTests
//
//  Created by Happymoonday on 8/13/24.
//

import XCTest
import Domain
import MockData

final class DeleteWeightUsecaseTests: XCTestCase {
    func testExample() {
        let repository = WeightRepositoryMock()
        let usecase = DeleteWeightUsecase(weightRepository: repository)
        usecase.implement(weight: WEIGHTS[0])
        XCTAssertEqual(repository.get().count, WEIGHTS.count - 1)
    }
}
