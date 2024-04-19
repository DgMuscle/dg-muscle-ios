//
//  exerciseTests.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/13/24.
//

import XCTest

final class exerciseTests: XCTestCase {

    func testExerciseSection() async throws {
        
        let viewModel = ExerciseListV2ViewModel(exerciseRepository: ExerciseRepositoryV2Test())
        
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        var keyCount: Int = 0
        var exerciseCount: Int = 0
        
        for section in viewModel.sections {
            keyCount += 1
            
            for _ in section.exercises {
                exerciseCount += 1
            }
        }
          
        XCTAssertEqual(keyCount, 4)
        XCTAssertEqual(exerciseCount, 6)
    }
}
