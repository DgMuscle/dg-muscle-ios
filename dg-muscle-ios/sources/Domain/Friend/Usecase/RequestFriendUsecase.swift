//
//  RequestFriendUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation

public final class RequestFriendUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement(userId: String) async throws {
        try await friendRepository.requestFriend(userId: userId)
    }
}
