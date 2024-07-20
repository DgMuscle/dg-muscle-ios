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
        
        let history = HISTORIES[0]
        
        let result = usecase.implement(history: history, record: history.records[0])
        XCTAssertEqual(result?.exerciseId, "C43C0CD2-1F65-447F-BB87-4206B8B8CB36")
    }
}
