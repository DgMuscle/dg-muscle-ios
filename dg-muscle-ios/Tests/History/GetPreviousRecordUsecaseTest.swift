//
//  GetPreviousRecordUsecaseTest.swift
//  AppTests
//
//  Created by Donggyu Shin on 5/27/24.
//

import XCTest
import Domain
import MockData

final class GetPreviousRecordUsecaseTest: XCTestCase {
    func testImplement() throws {
        let historyRepository = HistoryRepositoryMock()
        let usecase = GetPreviousRecordUsecase(historyRepository: historyRepository)
        
        let result = usecase.implement(history: HISTORY_1, record: HISTORY_1.records.first!)
        XCTAssertEqual(result?.exerciseId, "squat")
    }
}
