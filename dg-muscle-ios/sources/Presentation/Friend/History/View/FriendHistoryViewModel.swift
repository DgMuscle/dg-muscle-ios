//
//  FriendHistoryViewModel.swift
//  Friend
//
//  Created by Donggyu Shin on 6/14/24.
//

import Foundation
import Combine
import Domain

final class FriendHistoryViewModel: ObservableObject {
    
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
    }
}
