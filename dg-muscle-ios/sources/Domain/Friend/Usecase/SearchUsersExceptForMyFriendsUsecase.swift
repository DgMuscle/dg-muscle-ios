//
//  SearchUsersExceptForMyFriendsUsecase.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation

public final class SearchUsersExceptForMyFriendsUsecase {
    private let friendRepository: FriendRepository
    private let userRepository: UserRepository
    
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
    }
    
    public func implement(query: String) -> [User] {
        var users = friendRepository.getUsers()
        users = excludeFriendsAndMeAndSort(users: users)
        
        guard query.isEmpty == false else { return users }
        
        users = users
            .filter({
                let displayName = ($0.displayName ?? "").lowercased()
                return displayName.contains(query.lowercased())
            })
        
        return users
    }
    
    private func excludeFriendsAndMeAndSort(users: [User]) -> [User] {
        let myUid = userRepository.get()?.uid ?? ""
        let myFriendUids = friendRepository.getFriends().map { $0.uid }
        var excludeIds: [String] = []
        excludeIds.append(contentsOf: myFriendUids)
        excludeIds.append(myUid)
        
        var users = users
        
        users = users
            .filter({ !excludeIds.contains($0.uid) })
            .sorted(by: { user1, user2 in
                if user1.photoURL != nil && user2.photoURL == nil {
                    return true
                }
                
                if (user1.displayName?.isEmpty == false) && (user2.displayName?.isEmpty != false) {
                    return true
                }
                
                if user1.backgroundImageURL != nil && user2.backgroundImageURL == nil {
                    return true 
                }
                
                return false
            })
        
        return users
    }
}
