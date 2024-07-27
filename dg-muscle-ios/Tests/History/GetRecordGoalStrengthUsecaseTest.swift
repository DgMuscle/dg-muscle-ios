//
//  GetRecordGoalStrengthUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 7/13/24.
//

import XCTest
import Domain

final class GetRecordGoalStrengthUsecaseTest: XCTestCase {
    
    func testEdgeCase() {
        // given
        let useCase = GetRecordGoalStrengthUsecase()
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 3, weight: 70),
                .init(id: UUID().uuidString, unit: .kg, reps: 7, weight: 70),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 70),
                .init(id: UUID().uuidString, unit: .kg, reps: 3, weight: 70),
                .init(id: UUID().uuidString, unit: .kg, reps: 3, weight: 70)
            ]
        )
        
        // when
        let goal = useCase.implement(previousRecord: record)
        
        // then
        XCTAssertEqual(goal?.weight, 70)
        XCTAssertEqual(goal?.reps, 5)
    }
    
    func testMoreWeight() {
        // given
        let useCase = GetRecordGoalStrengthUsecase()
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 15, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 15, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 5, weight: 60)
            ]
        )
        
        // when
        let goal = useCase.implement(previousRecord: record)
        
        // then
        XCTAssertEqual(goal?.weight, 65)
        XCTAssertEqual(goal?.reps, 5)
    }

    func testSameWeigth() {
        // given
        let useCase = GetRecordGoalStrengthUsecase()
        
        let record: ExerciseRecord = .init(
            id: UUID().uuidString,
            exerciseId: "squat",
            sets: [
                .init(id: UUID().uuidString, unit: .kg, reps: 15, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 15, weight: 60),
                .init(id: UUID().uuidString, unit: .kg, reps: 15, weight: 60)
            ]
        )
        
        // when
        let goal = useCase.implement(previousRecord: record)
        
        // then
        XCTAssertEqual(goal?.weight, 60)
        XCTAssertEqual(goal?.reps, 5)
    }

}
