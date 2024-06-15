//
//  HistoryDetailViewModel.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Combine
import Domain

final class HistoryDetailViewModel: ObservableObject {
    
    @Published var history: History?
    
    private let getFriendHistoriesUsecase: GetFriendHistoriesUsecase
    private let friendId: String
    private let historyId: String
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: any FriendRepository,
        friendId: String,
        historyId: String
    ) {
        getFriendHistoriesUsecase = .init(friendRepository: friendRepository)
        self.friendId = friendId
        self.historyId = historyId
        
        configureHistory()
    }
    
    private func configureHistory() {
        Task {
            let histories = try await getFriendHistoriesUsecase.implement(friendId: friendId)
            guard let history = histories.first(where: { $0.id == historyId }) else { return }
            self.history = .init(domain: history)
        }
    }
}
