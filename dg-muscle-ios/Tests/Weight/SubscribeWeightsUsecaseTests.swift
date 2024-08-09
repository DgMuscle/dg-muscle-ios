//
//  SubscribeWeightsUsecaseTests.swift
//  AppTests
//
//  Created by Donggyu Shin on 8/6/24.
//

import XCTest
import Domain
import MockData
import Combine

final class SubscribeWeightsUsecaseTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    func testExample() throws {
        let repository: WeightRepository = WeightRepositoryMock()
        let usecase = SubscribeWeightsUsecase(weightRepository: repository)
        
        let exp = expectation(description: "Loading weights")
        
        usecase.implement()
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { weights in
                XCTAssertEqual(WEIGHTS.count - 1, weights.count)
                exp.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 3)
    }
}
