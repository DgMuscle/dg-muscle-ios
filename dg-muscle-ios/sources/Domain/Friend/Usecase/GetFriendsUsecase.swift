//
//  GetFriendsUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/26/24.
//

import Foundation

public final class GetFriendsUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement() -> [User] {
        friendRepository.getFriends()
    }
}
