//
//  RefuseFriendUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

final class RefuseFriendUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(request: FriendRequestDomain) async throws {
        try await friendRepository.refuse(request: request)
    }
}
