//
//  SubscribeRapidAllExercisesUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 7/21/24.
//

import XCTest
import MockData
import Domain
import Combine

final class SubscribeRapidAllExercisesUsecaseTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    func testData() throws {
        
        let expectation = XCTestExpectation(description: "Read rapid exercises from a json file asynchronously.")
        
        let usecase = SubscribeRapidAllExercisesUsecase(rapidRepository: RapidRepositoryMock())
        usecase.implement()
            .sink { exercises in
                XCTAssertEqual(1000, exercises.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
    }

}
