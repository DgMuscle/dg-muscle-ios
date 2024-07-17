//
//  GetExercisePopularityUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 7/17/24.
//

import XCTest
import Domain
import MockData

final class GetExercisePopularityUsecaseTest: XCTestCase {

    func testUsecase() throws {
        let usecase = GetExercisePopularityUsecase(
            exerciseRepository: ExerciseRepositoryMock(),
            historyRepository: HistoryRepositoryMock()
        )
        let result = usecase.implement()
        
        XCTAssertEqual(1, result["squat"])
    }

}
