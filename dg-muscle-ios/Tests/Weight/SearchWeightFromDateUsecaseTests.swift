//
//  SearchWeightFromDateUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 8/6/24.
//

import XCTest
import Domain
import MockData

final class SearchWeightFromDateUsecaseTests: XCTestCase {

    func testExample() throws {
        let repository: WeightRepository = WeightRepositoryMock()
        let usecase = SearchWeightFromDateUsecase(weightRepository: repository)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: "20240719")!
        
        let weight = usecase.implement(date: date)
        XCTAssertEqual("20240718", weight?.yyyyMMdd)
    }
}
