//
//  CheckStrengthGoalAchievedUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 7/13/24.
//

import XCTest
import Domain

final class CheckStrengthGoalAchievedUsecaseTest: XCTestCase {
    
    func testFalseCase() {
        // given
        let usecase = CheckStrengthGoalAchievedUsecase()
        let goal: ExerciseSet = .init(
            id: UUID().uuidString,
            unit: .kg,
            reps: 5,
            weight: 65
        )
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
            ]
        )
        
        // when
        let result = usecase.implement(goal: goal, record: record)
        
        // then
        XCTAssertFalse(result)
    }

    func testTrueCase() {
        // given
        let usecase = CheckStrengthGoalAchievedUsecase()
        let goal: ExerciseSet = .init(
            id: UUID().uuidString,
            unit: .kg,
            reps: 5,
            weight: 60
        )
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
            ]
        )
        
        // when
        let result = usecase.implement(goal: goal, record: record)
        
        // then
        XCTAssertTrue(result)
    }
}
