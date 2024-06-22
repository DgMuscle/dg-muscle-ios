//
//  SubscribeLogBadgeUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 6/22/24.
//

import XCTest
import Domain
import MockData
import Combine

final class SubscribeLogBadgeUsecaseTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testExample() throws {
        let expectation = self.expectation(description: "SubscribeLogBadgeUsecase completes")
        
        let usecase = SubscribeLogBadgeUsecase(logRepository: LogRepositoryMock())
        usecase
            .implement()
            .sink { hasBadge in
                XCTAssertTrue(hasBadge)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
