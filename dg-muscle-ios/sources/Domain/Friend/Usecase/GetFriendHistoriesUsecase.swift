//
//  GetFriendHistoriesUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 6/14/24.
//

import Foundation

public final class GetFriendHistoriesUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement(friendId: String) async throws -> [History] {
        try await friendRepository.getHistories(friendId: friendId)
    }
}
