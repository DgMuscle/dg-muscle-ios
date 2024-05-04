//
//  AcceptFriendUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

final class AcceptFriendUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(request: FriendRequestDomain) async throws {
        try await friendRepository.accept(request: request)
    }
}
