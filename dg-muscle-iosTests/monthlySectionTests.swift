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
        
        XCTAssertEqual(viewModel.datas[0].part, .arm)
        XCTAssertEqual(viewModel.datas[0].volume, 70000.0)
        XCTAssertEqual(viewModel.datas[3].volume, 105000.0)
        
        XCTAssertEqual(viewModel.mostPart, .leg)
        XCTAssertEqual(viewModel.leastPart, .chest)
        
        XCTAssertEqual(viewModel.mostVolume, 22750.0)
        XCTAssertEqual(viewModel.leastVolume, 8750.0)
        
        XCTAssertEqual(viewModel.mostExercise?.id, "squat")
        XCTAssertEqual(viewModel.leastExercise?.id, "arm curl")
    }

}
