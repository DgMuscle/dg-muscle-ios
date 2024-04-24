//
//  FriendsSearchViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import Foundation
import Combine

final class FriendsSearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    @Published var searchedUsers: [SearchedUser] = []
    
    @Published private var dgusers: [DGUser] = []
    @Published private var myFriends: [Friend] = []
    
    let userRepository: UserRepositoryV2
    let friendRepository: FriendRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2, 
         friendRepository: FriendRepository) {
        self.userRepository = userRepository
        self.friendRepository = friendRepository
        
        bind()
    }
    
    func searchUsers(query: String, dgusers: [DGUser], myFriends: [Friend]) {
        
    }
    
    private func bind() {
        userRepository.dgUsersPublisher
            .sink { [weak self] users in
                self?.dgusers = users
            }
            .store(in: &cancellables)
        
        friendRepository.friendsPublisher
            .sink { [weak self] friends in
                self?.myFriends = friends
            }
            .store(in: &cancellables)
        
        $query
            .combineLatest($dgusers, $myFriends)
            .sink { [weak self] query, users, friends in
                self?.searchUsers(query: query, dgusers: users, myFriends: friends)
            }
            .store(in: &cancellables)
    }
}

extension FriendsSearchViewModel {
    struct SearchedUser {
        let user: DGUser
        var isMyFriend: Bool
    }
}
