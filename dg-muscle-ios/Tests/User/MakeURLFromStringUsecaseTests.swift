//
//  MakeURLFromStringUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 8/3/24.
//

import XCTest
import Domain

final class MakeURLFromStringUsecaseTests: XCTestCase {
    
    let usecase = MakeURLFromStringUsecase()

    func testWithoutPrefix() {
        XCTAssertNotNil(usecase.implement(link: "www.naver.com"))
    }
    
    func testWithPrefix() {
        XCTAssertNotNil(usecase.implement(link: "https://www.naver.com"))
        XCTAssertNotNil(usecase.implement(link: "http://www.naver.com"))
    }
    
    func testEmpty() {
        XCTAssertNil(usecase.implement(link: ""))
    }
    
    func testFail() {
        XCTAssertNil(usecase.implement(link: "  "))
    }
}
