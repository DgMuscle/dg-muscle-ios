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
        
        XCTAssertEqual(0.65, result["970C5E9E-780D-4C0F-BA6E-337580B04229"])
    }

}
