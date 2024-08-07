//
//  GroupWeightsByGroupUsecaseTests.swift
//  AppTests
//
//  Created by Donggyu Shin on 8/7/24.
//

import XCTest
import Domain
import MockData

final class GroupWeightsByGroupUsecaseTests: XCTestCase {

    func testExample() throws {
        let usecase = GroupWeightsByGroupUsecase()
        let repository = WeightRepositoryMock()
        let result = usecase.implement(weights: repository.get())
        XCTAssertEqual(result.count, 6)
    }
}
