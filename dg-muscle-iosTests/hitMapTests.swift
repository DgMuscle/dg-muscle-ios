//
//  hitMapTests.swift
//  dg-muscle-iosTests
//
//  Created by Donggyu Shin on 4/15/24.
//

import XCTest
import Combine

final class hitMapTests: XCTestCase {

    func testHashMap() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: "20240415")!
        let viewModel = WorkoutHitMapViewModel(historyRepository: HistoryRepositoryV2Test(), today: date)
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }

}
