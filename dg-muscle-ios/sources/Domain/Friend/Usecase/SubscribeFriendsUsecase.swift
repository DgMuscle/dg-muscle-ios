//
//  SubscribeFriendsUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Combine

public final class SubscribeFriendsUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement() -> AnyPublisher<[User], Never> {
        friendRepository.friends
    }
}
