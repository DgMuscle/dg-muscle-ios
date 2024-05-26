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
    private let userRepository: UserRepository
    private let myUid: String
    
    @Published private var users: [User] = []
    
    private var cancellables = Set<AnyCancellable>()
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
        self.myUid = userRepository.get()?.uid ?? ""
        bind()
    }
    
    public func implement() -> AnyPublisher<[User], Never> {
        $users.eraseToAnyPublisher()
    }
    
    private func bind() {
        friendRepository
            .users
            .combineLatest(friendRepository.friends)
            .map({ [weak self] users, friends in
                guard let self else { return [] }
                var excludeIds = friends.map({ $0.uid })
                excludeIds.append(myUid)
                var users = users
                users = users
                    .filter({ !excludeIds.contains($0.uid) })
                return users
            })
            .map({ (users: [User]) in
                var users = users
                users = users
                    .sorted(by: { user1, user2 in
                        let user1HasProfilePhoto = user1.photoURL != nil
                        let user1HasBackgroundPhoto = user1.backgroundImageURL != nil
                        let user2HasProfilePhoto = user2.photoURL != nil
                        
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
