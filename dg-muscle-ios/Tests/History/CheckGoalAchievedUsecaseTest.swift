//
//  CheckGoalAchievedUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 7/13/24.
//

import XCTest
import Domain

final class CheckGoalAchievedUsecaseTest: XCTestCase {

    func testAchieved() {
        // given
        let usecase = CheckGoalAchievedUsecase()
        
        let goal: ExerciseSet = .init(
            id: UUID().uuidString,
            unit: .kg,
            reps: 13,
            weight: 60
        )
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 13, weight: 60)
            ]
        )
        
        // when
        let result = usecase.implement(goal: goal, record: record)
        
        // then
        XCTAssertTrue(result)
    }
    
    func testNotAchieved() {
        // given
        let usecase = CheckGoalAchievedUsecase()
        
        let goal: ExerciseSet = .init(
            id: UUID().uuidString,
            unit: .kg,
            reps: 13,
            weight: 60
        )
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60)
            ]
        )
        
        // when
        let result = usecase.implement(goal: goal, record: record)
        
        // then
        XCTAssertFalse(result)
    }

}
