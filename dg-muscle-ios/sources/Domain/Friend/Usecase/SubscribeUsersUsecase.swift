//
//  SubscribeUsersUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Combine

public final class SubscribeUsersUsecase {
    private let friendRepository: FriendRepository
    
    @Published private var users: [User] = []
    
    private var cancellables = Set<AnyCancellable>()
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
        
        bind()
    }
    
    public func implement() -> AnyPublisher<[User], Never> {
        $users.eraseToAnyPublisher()
    }
    
    private func bind() {
        friendRepository
            .users
            .combineLatest(friendRepository.friends)
            .map({ users, friends in
                let friendIds = friends.map({ $0.uid })
                var users = users
                users = users
                    .filter({ !friendIds.contains($0.uid) })
                return users
            })
            .map({ (users: [User]) in
                var users = users
                users = users
                    .sorted(by: { user1, user2 in
                        let user1HasProfilePhoto = user1.photoURL != nil
                        let user1HasBackgroundPhoto = user1.backgroundImageURL != nil
                        let user2HasProfilePhoto = user2.photoURL != nil
                        let user2HasBackgroundPhoto = user2.backgroundImageURL != nil
                        
                        if user1HasProfilePhoto && user1HasBackgroundPhoto {
                            return true
                        }
                        
                        if user1HasProfilePhoto && !user2HasProfilePhoto {
                            return true
                        }
                        
                        return false
                    })
                
                return users
            })
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }
}
