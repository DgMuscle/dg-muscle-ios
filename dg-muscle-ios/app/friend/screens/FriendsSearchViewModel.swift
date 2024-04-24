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
    
    let me: DGUser?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2, 
         friendRepository: FriendRepository) {
        self.userRepository = userRepository
        self.friendRepository = friendRepository
        me = userRepository.user
        
        bind()
    }
    
    private func searchUsers(query: String, dgusers: [DGUser], myFriends: [Friend]) {
        var usersMap: [String: String] = [:]
        let query = query.lowercased().filter({ !$0.isWhitespace })
        let myFriendIds: [String] = myFriends.map({ $0.uid })
        
        for user in dgusers {
            if var name = user.displayName {
                if user.uid != me?.uid {
                    name = name.lowercased().filter({ !$0.isWhitespace })
                    usersMap[name] = user.uid
                }
            }
        }
        
        var searchedUsers: [SearchedUser] = []
        
        for (name, id) in usersMap {
            if name.contains(query) {
                if let user = dgusers.first(where: { $0.uid == id }) {
                    let isMyFriend = myFriendIds.contains(id)
                    searchedUsers.append(.init(user: user, isMyFriend: isMyFriend))
                }
            }
        }
        
        self.searchedUsers = searchedUsers
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
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
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
