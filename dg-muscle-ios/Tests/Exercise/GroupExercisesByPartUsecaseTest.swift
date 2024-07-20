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
        // given
        let onlyShowsFavorite: Bool = false
        let usecase = Domain.GroupExercisesByPartUsecase()
        
        // when
        let result = usecase.implement(
            exercises: exercisesFromJsonResponse,
            onlyShowsFavorite: onlyShowsFavorite
        )
        
        // then
        XCTAssertEqual(8, result[.leg]?.count)
        XCTAssertEqual(8, result[.back]?.count)
        XCTAssertEqual(5, result[.chest]?.count)
        
    }
}
