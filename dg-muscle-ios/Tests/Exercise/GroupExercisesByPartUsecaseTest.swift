//
//  GroupExercisesByPartUsecaseTest.swift
//  Test
//
//  Created by 신동규 on 5/19/24.
//

import XCTest
import MockData
import Domain

//public let EXERCISE_SQUAT: Exercise = .init(id: "squat", name: "Squat", parts: [.leg], favorite: true)
//public let EXERCISE_BENCH: Exercise = .init(id: "bench press", name: "Bench Press", parts: [.chest], favorite: false)
//public let EXERCISE_DEAD: Exercise = .init(id: "deadlift", name: "Deadlift", parts: [.leg, .back], favorite: true)

final class GroupExercisesByPartUsecaseTest: XCTestCase {

    func testExample() throws {
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
