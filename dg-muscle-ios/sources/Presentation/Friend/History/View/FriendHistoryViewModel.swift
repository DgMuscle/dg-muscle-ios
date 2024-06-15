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
    
    @Published var historySection: [Common.HistorySection] = []
    @Published var status: Common.StatusView.Status? = nil
    @Published var user: Common.User?
    
    private let friendId: String
    private let getFriendHistoriesUsecase: GetFriendHistoriesUsecase
    private let getUserFromUidUsecase: GetUserFromUidUsecase
    private let getFriendExercisesUsecase: GetFriendExercisesUsecase
    private let groupByMonthHistoriesUsecase: GroupByMonthHistoriesUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: any FriendRepository,
        friendId: String
    ) {
        self.friendId = friendId
        getFriendHistoriesUsecase = .init(friendRepository: friendRepository)
        getUserFromUidUsecase = .init(friendRepository: friendRepository)
        getFriendExercisesUsecase = .init(friendRepository: friendRepository)
        groupByMonthHistoriesUsecase = .init()
        
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
                
                let grouped = groupByMonthHistoriesUsecase.implement(histories: histories)
                
                historySection = configureData(grouped: grouped, exercises: exercises, color: color)
                
                status = nil
            } catch {
                status = .error(error.localizedDescription)
            }
        }
    }
    
    private func configureData(grouped: [String: [Domain.History]], exercises: [Domain.Exercise], color: Color) -> [HistorySection] {
        var data: [HistorySection] = []
        
        let dateFormatter = DateFormatter()
        
        for (month, histories) in grouped {
            let historyList: [Common.HistoryItem] = histories.map({
                .init(
                    history: $0,
                    exercises: exercises,
                    color: color
                )
            })
            dateFormatter.dateFormat = "yyyyMM"
            let date = dateFormatter.date(from: month) ?? Date()
            dateFormatter.dateFormat = "MMM y"
            
            data.append(
                .init(
                    id: UUID().uuidString,
                    yearMonth: dateFormatter.string(from: date),
                    histories: historyList,
                    yyyyMM: month
                )
            )
        }
        
        data.sort(by: { $0.yyyyMM > $1.yyyyMM })
        
        return data
    }
}
