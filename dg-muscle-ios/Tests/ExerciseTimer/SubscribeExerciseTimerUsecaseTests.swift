//
//  SubscribeExerciseTimerUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 8/11/24.
//

import XCTest
import Domain
import MockData
import Combine

final class SubscribeExerciseTimerUsecaseTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    func testExample() throws {
        let usecase = SubscribeExerciseTimerUsecase(exerciseTimerRepository: ExerciseTimerRepositoryMockData())
        
        let expectation = self.expectation(description: "subscribe timer")
        
        usecase
            .implement()
            .sink { timer in
                XCTAssertNotNil(timer)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
    }

}
