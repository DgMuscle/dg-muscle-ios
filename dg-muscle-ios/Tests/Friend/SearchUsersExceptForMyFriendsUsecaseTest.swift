//
//  SearchUsersExceptForMyFriendsUsecaseTest.swift
//  AppTests
//
//  Created by 신동규 on 5/26/24.
//

import XCTest
import Domain
import MockData

final class SearchUsersExceptForMyFriendsUsecaseTest: XCTestCase {
    
    let usecase = SearchUsersExceptForMyFriendsUsecase(
        friendRepository: FriendRepositoryMock(),
        userRepository: UserRepositoryMock()
    )
    
    func testEmptyResult() {
        let users = usecase.implement(query: "낙용")
        XCTAssertTrue(users.isEmpty)
    }

    func testWithQuery() {
        let users = usecase.implement(query: "CO")
        XCTAssertEqual(users.first!.displayName?.lowercased(), "conan")
    }
    
    func testWithoutQuery() throws {
        
        let users = usecase.implement(query: "")
        
        let ids = users.map({ $0.uid })
        XCTAssertFalse(ids.contains(UserRepositoryMock().get()?.uid ?? ""))
    }

}
