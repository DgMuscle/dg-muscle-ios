//
//  DeleteFriendUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 6/14/24.
//

import Foundation

public final class DeleteFriendUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    public func implement(friendId: String) async throws {
        try await friendRepository.delete(friendId: friendId)
    }
}
