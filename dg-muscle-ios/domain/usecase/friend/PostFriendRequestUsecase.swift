//
//  PostFriendRequestUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

final class PostFriendRequestUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(userId: String) async throws {
        try await friendRepository.postRequest(userId: userId)
    }
}
