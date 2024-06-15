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
    
    func getUser(uid: String) -> User?
    func getFriends() -> [User]
    func getUsers() -> [User]
    func getHistories(friendId: String) async throws -> [History]
    func getExercises(friendId: String) async throws -> [Exercise]
    func requestFriend(userId: String) async throws
    func accept(request: FriendRequest) async throws
    func refuse(request: FriendRequest) async throws
    func delete(friendId: String) async throws
}
