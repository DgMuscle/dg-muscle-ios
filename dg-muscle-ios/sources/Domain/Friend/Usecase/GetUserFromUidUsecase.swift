//
//  GetUserFromUidUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/26/24.
//

import Foundation

public final class GetUserFromUidUsecase {
    private let friendRepository: FriendRepository
    
    public init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    public func implement(uid: String) -> User? {
        let users = friendRepository.getUsers()
        return users.first(where: { $0.uid == uid })
    }
}
