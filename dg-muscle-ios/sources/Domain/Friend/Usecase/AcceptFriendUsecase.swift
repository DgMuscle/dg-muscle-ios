//
//  AcceptFriendUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation

public final class AcceptFriendUsecase {
    private let friendRepository: FriendRepository
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    public func implement(request: FriendRequest) async throws {
        try await friendRepository.accept(request: request)
    }
}
