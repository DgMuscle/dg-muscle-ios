//
//  GetHistoriesFromUidUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation

final class GetHistoriesFromUidUsecase {
    let friendRepository: FriendRepository
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func implement(uid: String) async throws -> [HistoryDomain] {
        try await friendRepository.get(uid: uid)
    }
}
