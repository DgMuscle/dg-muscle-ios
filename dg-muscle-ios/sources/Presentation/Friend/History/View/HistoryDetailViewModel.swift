//
//  HistoryDetailViewModel.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import Foundation
import Combine
import Domain
import SwiftUI
import Common

final class HistoryDetailViewModel: ObservableObject {
    
    @Published var history: History?
    @Published var color: Color
    @Published var totalVolume: Int = 0
    
    private let getFriendHistoriesUsecase: GetFriendHistoriesUsecase
    private let getFriendExercisesUsecase: GetFriendExercisesUsecase
    private let getUserFromUidUsecase: GetUserFromUidUsecase
    private let friendId: String
    private let historyId: String
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: any FriendRepository,
        friendId: String,
        historyId: String
    ) {
        getFriendHistoriesUsecase = .init(friendRepository: friendRepository)
        getFriendExercisesUsecase = .init(friendRepository: friendRepository)
        getUserFromUidUsecase = .init(friendRepository: friendRepository)
        
        self.friendId = friendId
        self.historyId = historyId
        
        if let user = getUserFromUidUsecase.implement(uid: friendId) {
            color = Common.HeatMapColor(domain: user.heatMapColor).color
        } else {
            color = .green
        }
        
        Task {
            await configureHistory()
        }
        
        bind()
    }
    
    private func bind() {
        $history
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .map({ $0.volume })
            .assign(to: &$totalVolume)
    }
    
    @MainActor
    private func configureHistory() {
        Task {
            async let historiesTask = getFriendHistoriesUsecase.implement(friendId: friendId)
            async let exercisesTask = getFriendExercisesUsecase.implement(friendId: friendId)
            
            let histories = try await historiesTask
            let exercises = try await exercisesTask
            
            guard let historyDomain = histories.first(where: { $0.id == historyId }) else { return }
            var history: History = .init(domain: historyDomain)
            
            for (index, record) in history.records.enumerated() {
                
                if let exercise = exercises.first(where: { $0.id == record.exerciseId }) {
                    history.records[index].exerciseName = exercise.name
                }
            }
            
            self.history = history
        }
    }
}
