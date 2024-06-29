//
//  SearchUsersViewModel.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Combine
import Common

final class SearchUsersViewModel: ObservableObject {
    @Published var users: [Common.User] = []
    @Published var query: String = ""
    @Published var status: Common.StatusView.Status? = nil
    
    private let searchUsersExceptForMyFriendsUsecase: SearchUsersExceptForMyFriendsUsecase
    private let requestFriendUsecase: RequestFriendUsecase
    private let subscribeFriendsUsecase: SubscribeFriendsUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        searchUsersExceptForMyFriendsUsecase = .init(
            friendRepository: friendRepository,
            userRepository: userRepository
        )
        
        requestFriendUsecase = .init(friendRepository: friendRepository)
        
        subscribeFriendsUsecase = .init(friendRepository: friendRepository)
        
        bind()
    }
    
    private var requestFriend: Task<(), Never>? = nil
    @MainActor
    func requestFriend(userId: String) {
        guard requestFriend == nil else { return }
        requestFriend = Task {
            status = .loading
            do {
                try await requestFriendUsecase.implement(userId: userId)
                status = .success("Done!")
            } catch {
                status = .error(error.localizedDescription)
            }
            requestFriend = nil
        }
    }
    
    private func bind() {
        $query
            .combineLatest(subscribeFriendsUsecase.implement())
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({ [weak self] query, _ in
                guard let self else { return [] }
                let domainUsers: [Domain.User] = searchUsersExceptForMyFriendsUsecase.implement(query: query)
                let users: [Common.User] = domainUsers.map({ .init(domain: $0) })
                return users
            })
            .assign(to: &$users)
    }
}
