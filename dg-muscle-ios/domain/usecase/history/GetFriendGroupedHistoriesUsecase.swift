//
//  GetFriendGroupedHistoriesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation

final class GetFriendGroupedHistoriesUsecase {
    let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement(friendId: String) async throws -> [[HistoryDomain]] {
        let histories = try await historyRepository.get(uid: friendId)
        let grouped = GetGroupedHistoriesUsecase().implement(histories: histories)
        return grouped
    }
}
