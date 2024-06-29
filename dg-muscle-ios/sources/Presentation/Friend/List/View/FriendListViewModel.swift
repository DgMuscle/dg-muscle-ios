//
//  FriendListViewModel.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Combine

final class FriendListViewModel: ObservableObject {
    @Published var friends: [Friend]
    
    private let subscribeFriendsUsecase: SubscribeFriendsUsecase
    private let getFriendsUsecase: GetFriendsUsecase
    private let deleteFriendUsecase: DeleteFriendUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(friendRepository: FriendRepository) {
        subscribeFriendsUsecase = .init(friendRepository: friendRepository)
        getFriendsUsecase = .init(friendRepository: friendRepository)
        deleteFriendUsecase = .init(friendRepository: friendRepository)
        friends = getFriendsUsecase
            .implement()
            .map({ Friend(domain: $0) })
        bind()
    }
    
    func delete(friendId: String) {
        Task {
            try await deleteFriendUsecase.implement(friendId: friendId)
        }
    }
    
    private func bind() {
        subscribeFriendsUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .map({ $0.map({ Friend(domain: $0) }) })
            .assign(to: &$friends)
    }
}
