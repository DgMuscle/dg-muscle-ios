//
//  SearchRapidExercisesByBodyPartsUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 7/21/24.
//

import XCTest
import Domain
import MockData

final class SearchRapidExercisesByBodyPartsUsecaseTests: XCTestCase {


    func testAllParts() throws {
        let usecase = SearchRapidExercisesByBodyPartsUsecase(rapidRepository: RapidRepositoryMock())
        
        let result = usecase.implement(parts: [
            .back,
            .cardio,
            .chest,
            .lowerArms,
            .lowerLegs,
            .neck,
            .shoulders,
            .upperArms,
            .upperLegs,
            .waist
        ])
        
        XCTAssertEqual(100, result.count)
    }
    
    func testEmptyCase() {
        let usecase = SearchRapidExercisesByBodyPartsUsecase(rapidRepository: RapidRepositoryMock())
        let result = usecase.implement(parts: [])
        
        XCTAssertEqual(0, result.count)
    }
}
