//
//  SearchRapidExercisesByNameUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 7/21/24.
//

import XCTest
import Domain
import MockData

final class SearchRapidExercisesByNameUsecaseTests: XCTestCase {

    func testExample() throws {
        let usecase = SearchRapidExercisesByNameUsecase(rapidRepository: RapidRepositoryMock())
        let exercises = usecase.implement(name: "squat")
        
        let allNames = exercises.map { $0.name }
        XCTAssertTrue(allNames.contains("band one arm single leg split squat"))
    }
    
    func testCapitalCase() {
        let usecase = SearchRapidExercisesByNameUsecase(rapidRepository: RapidRepositoryMock())
        let exercises = usecase.implement(name: "Squat")
        
        let allNames = exercises.map { $0.name }
        XCTAssertTrue(allNames.contains("band one arm single leg split squat"))
    }
}
