//
//  monthlySectionTests.swift
//  dg-muscle-iosTests
//
//  Created by Donggyu Shin on 4/19/24.
//

import XCTest

final class monthlySectionTests: XCTestCase {
    func testConfigureData() throws {
        
        let histories: [ExerciseHistorySection.History] =
        HistoryRepositoryV2Test().histories.map({ .init(exercise: $0, metadata: nil) })
        let sectionData = ExerciseHistorySection(histories: histories)
        
        let viewModel = MonthlySectionViewModel(exerciseHistorySection: sectionData)
    }

}
