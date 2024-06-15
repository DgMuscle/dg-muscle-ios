//
//  GetFriendExercisesUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/14/24.
//

import Foundation

public final class GetFriendExercisesUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement(friendId: String) async throws -> [Exercise] {
        try await friendRepository.getExercises(friendId: friendId)
    }
}
