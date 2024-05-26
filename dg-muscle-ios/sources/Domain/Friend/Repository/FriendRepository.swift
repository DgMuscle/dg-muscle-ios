//
//  FriendRepository.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Combine

public protocol FriendRepository {
    var friends: AnyPublisher<[User], Never> { get }
    var requests: AnyPublisher<[FriendRequest], Never> { get }
    var users: AnyPublisher<[User], Never> { get }
    
    func getFriends() -> [User]
    func requestFriend(userId: String) async throws
    func accept(request: FriendRequest) async throws
    func refuse(request: FriendRequest) async throws
}
