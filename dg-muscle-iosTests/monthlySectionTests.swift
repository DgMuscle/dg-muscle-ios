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
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertEqual(viewModel.datas[0].part, .arm)
        XCTAssertEqual(viewModel.datas[0].volume, 38500.0)
        XCTAssertEqual(viewModel.datas[3].volume, 96250.0)
    }

}
