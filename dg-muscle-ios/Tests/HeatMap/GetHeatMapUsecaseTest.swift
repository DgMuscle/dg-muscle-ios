//
//  GetHeatMapUsecaseTest.swift
//  Test
//
//  Created by 신동규 on 5/15/24.
//

import XCTest
import Domain
import MockData

final class GetHeatMapUsecaseTest: XCTestCase {

    func testImplement() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: "20240615")!
        let usecase = GetHeatMapUsecase(today: date)
        let heatMap = usecase.implement(histories: historiesFromJsonResponse)
        
        let lastHeatmap = heatMap.last!
        XCTAssertEqual(lastHeatmap.volume.reduce(0, +), 25832.0)
    }
}
