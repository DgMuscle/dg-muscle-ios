//
//  FriendHistoryViewModel.swift
//  Friend
//
//  Created by Donggyu Shin on 6/14/24.
//

import Foundation
import Combine
import Domain
import Common
import SwiftUI

final class FriendHistoryViewModel: ObservableObject {
    
    @Published var histories: [Common.HistoryItem] = []
    @Published var status: Common.StatusView.Status? = nil
    @Published var user: Common.User?
    
    private let friendId: String
    private let getFriendHistoriesUsecase: GetFriendHistoriesUsecase
    private let getUserFromUidUsecase: GetUserFromUidUsecase
    private let getFriendExercisesUsecase: GetFriendExercisesUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: any FriendRepository,
        friendId: String
    ) {
        self.friendId = friendId
        getFriendHistoriesUsecase = .init(friendRepository: friendRepository)
        getUserFromUidUsecase = .init(friendRepository: friendRepository)
        getFriendExercisesUsecase = .init(friendRepository: friendRepository)
        
        if let domainUser = getUserFromUidUsecase.implement(uid: friendId) {
            self.user = .init(domain: domainUser)
        }
        
        configureHistories()
    }
    
    private func configureHistories() {
        Task {
            status = .loading
            do {
                async let historiesTask = getFriendHistoriesUsecase.implement(friendId: friendId)
                async let exercisesTask = getFriendExercisesUsecase.implement(friendId: friendId)
                
                let histories = try await historiesTask
                let exercises = try await exercisesTask
                let color: Color = self.user?.heatMapColor.color ?? .green
                
                self.histories = histories.map({
                    .init(history: $0, exercises: exercises, color: color)
                })
                
                status = nil
            } catch {
                status = .error(error.localizedDescription)
            }
        }
    }
}
