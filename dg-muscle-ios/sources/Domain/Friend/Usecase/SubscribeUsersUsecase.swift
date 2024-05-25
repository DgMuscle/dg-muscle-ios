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
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }
}
