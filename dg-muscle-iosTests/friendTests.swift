//
//  friendTests.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 4/24/24.
//

import XCTest

final class friendTests: XCTestCase {

    func testSearchFriends() async throws {
        let searchFriendsViewModel = FriendsSearchViewModel(userRepository: UserRepositoryV2Test(),
                                                            friendRepository: FriendRepositoryTest())
        
        searchFriendsViewModel.query = "낙"
        
        try await Task.sleep(nanoseconds: 5_000_000_000)
    }

}
