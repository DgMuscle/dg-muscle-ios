//
//  MakeStringFromURLUsecaseTests.swift
//  AppTests
//
//  Created by 신동규 on 8/3/24.
//

import XCTest
import Domain

final class MakeStringFromURLUsecaseTests: XCTestCase {
    
    let usecase = MakeStringFromURLUsecase()

    func testHttps() {
        let url = URL(string: "https://www.naver.com")!
        XCTAssertEqual("www.naver.com", usecase.implement(url: url))
    }
    
    func testHttp() {
        let url = URL(string: "http://www.naver.com")!
        XCTAssertEqual("www.naver.com", usecase.implement(url: url))
    }
}
