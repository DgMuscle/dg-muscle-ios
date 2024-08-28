//
//  ToggleTrainingModeUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 8/28/24.
//

import XCTest
import Domain
import MockData

final class ToggleTrainingModeUsecaseTests: XCTestCase {
    
    var userRepository: UserRepository?
    var usecase: ToggleTrainingModeUsecase?

    override func setUpWithError() throws {
        userRepository = UserRepositoryMock()
        usecase = .init(userRepository: userRepository!)
    }

    override func tearDownWithError() throws {
        userRepository = nil
        usecase = nil
    }

    func testExample() throws {
        let prevTrainingMode = userRepository?.get()?.trainingMode
        usecase?.implement()
        let nextTrainingMode = userRepository?.get()?.trainingMode
        
        XCTAssertNotEqual(prevTrainingMode, nextTrainingMode)
    }
}
