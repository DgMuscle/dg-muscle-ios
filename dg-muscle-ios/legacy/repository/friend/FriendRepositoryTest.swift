//
//  FriendRepositoryTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import Foundation
import Combine

final class FriendRepositoryTest: FriendRepository {
    var friends: [Friend] { _friends }
    var friendsPublisher: AnyPublisher<[Friend], Never> {
        $_friends.eraseToAnyPublisher()
    }
    @Published private var _friends: [Friend] = []
    
    init() {
        fetchFriends()
    }
    
    func fetchFriends() {
        _friends = [
            .init(uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2")
        ]
    }
}
