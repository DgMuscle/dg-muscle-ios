//
//  monthlySectionTests.swift
//  dg-muscle-iosTests
//
//  Created by Donggyu Shin on 4/19/24.
//

import XCTest

final class monthlySectionTests: XCTestCase {
    func testConfigureData() async throws {
        
        let histories: [ExerciseHistorySection.History] =
        HistoryRepositoryV2Test().histories.map({ .init(exercise: $0, metadata: nil) })
        let sectionData = ExerciseHistorySection(histories: histories)
        
        let viewModel = MonthlySectionViewModel(exerciseHistorySection: sectionData,
                                                exerciseRepository: ExerciseRepositoryV2Test())
        
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        XCTAssertEqual(viewModel.mostExercise?.name, "squat")
        XCTAssertEqual(viewModel.maxExerciseVolume, 57750.0)
        
        XCTAssertEqual(viewModel.mostPart, .leg)
        XCTAssertEqual(viewModel.maxPartVolume, 105000.0)
        
        XCTAssertEqual(viewModel.leastExercise?.name, "arm curl")
        XCTAssertEqual(viewModel.minExerciseVolume, 31500.0)
        
        XCTAssertEqual(viewModel.leastPart, .chest)
        XCTAssertEqual(viewModel.minPartVolume, 38500.0)
    }
}
