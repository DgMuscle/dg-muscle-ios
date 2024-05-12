//
//  GetFriendGroupedHistoriesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

final class GetFriendGroupedHistoriesUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(friendId: String) async throws -> [[HistoryDomain]] {
        let histories: [HistoryDomain] = try await friendRepository.get(uid: friendId)
        let grouped = GetGroupedHistoriesUsecase().implement(histories: histories)
        return grouped
    }
}
