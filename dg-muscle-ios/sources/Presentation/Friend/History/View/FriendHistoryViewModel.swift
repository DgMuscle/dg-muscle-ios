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
    
    private let getFriendHistoriesUsecase: GetFriendHistoriesUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: any FriendRepository
    ) {
        getFriendHistoriesUsecase = .init(friendRepository: friendRepository)
    }
}
