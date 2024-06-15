//
//  GroupExercisesByPartUsecaseTest.swift
//  Test
//
//  Created by 신동규 on 5/19/24.
//

import XCTest
import MockData
import Domain

final class GroupExercisesByPartUsecaseTest: XCTestCase {

    func testImplement() throws {
        let usecase = Domain.GroupExercisesByPartUsecase()
        
        let result = usecase.implement(exercises: [
            EXERCISE_SQUAT,
            EXERCISE_BENCH,
            EXERCISE_DEAD,
        ])
        
        XCTAssertEqual(2, result[.leg]?.count)
        XCTAssertEqual(1, result[.back]?.count)
        XCTAssertEqual(1, result[.chest]?.count)
        
    }
}
