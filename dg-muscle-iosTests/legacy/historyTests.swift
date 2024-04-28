//
//  historyTests.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/13/24.
//

import XCTest
import Combine

final class historyTests: XCTestCase {
    
    func testSetUpHistorySection() async throws {
        let viewModel = HistoryViewModel(historyRepository: HistoryRepositoryV2Test(), healthRepository: HealthRepositoryTest(), userRepository: UserRepositoryV2Test())
        
        try await Task.sleep(nanoseconds: 5_000_000_000)
        
        var sectionCount: Int = 0
        var historyCount: Int = 0
        var metadataCount: Int = 0
        
        for section in viewModel.historySections {
            sectionCount += 1
            for history in section.histories {
                historyCount += 1
                if history.metadata != nil {
                    metadataCount += 1
                }
            }
        }
        
        XCTAssertEqual(sectionCount, 3)
        XCTAssertEqual(historyCount, 11)
        XCTAssertEqual(metadataCount, 4)
    }
}
