//
//  CheckAddableExerciseUsecaseTests.swift
//  AppTests
//
//  Created by Happymoonday on 8/13/24.
//

import XCTest
import Domain
import MockData

final class CheckAddableExerciseUsecaseTests: XCTestCase {
    func testExample() {
        let usecase = CheckAddableExerciseUsecase(rapidRepository: RapidRepositoryMock())
        let exercise = RAPID_EXERCISES[0]
        XCTAssertTrue(usecase.implement(exercise: exercise))
    }
}
