//
//  hitMapTests.swift
//  dg-muscle-iosTests
//
//  Created by Donggyu Shin on 4/15/24.
//

import XCTest
import Combine

final class heatMapTests: XCTestCase {

    func testHashMap() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: "20240415")!
        let viewModel = WorkoutHeatMapViewModel(historyRepository: HistoryRepositoryV2Test(), 
                                                today: date,
                                                heatmapRepository: HeatmapRepositoryTest())
        
        try await Task.sleep(nanoseconds: 5_000_000_000)
        
        var dataCount: Int = 0
        var volumesCount: Int = 0
        
        for data in viewModel.datas {
            dataCount += 1
            for _ in data.volumes {
                volumesCount += 1
            }
        }
        
        XCTAssertEqual(dataCount, 17)
        XCTAssertEqual(volumesCount, 114)
    }
}
