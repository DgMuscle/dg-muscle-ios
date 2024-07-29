//
//  FriendRepositoryMock.swift
//  MockData
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Combine

public final class FriendRepositoryMock: FriendRepository {
    public var loading: AnyPublisher<Bool, Never> {
        $_loading.eraseToAnyPublisher()
    }
    
    @Published var _loading: Bool = true
    
    public var friends: AnyPublisher<[Domain.User], Never> { $_friends.eraseToAnyPublisher() }
    @Published var _friends: [Domain.User] = [
        USERS[0],
        USERS[1],
        USERS[2],
        USERS[3],
    ]
    
    public var requests: AnyPublisher<[Domain.FriendRequest], Never> { $_requests.eraseToAnyPublisher() }
    @Published var _requests: [Domain.FriendRequest] = [
        FRIEND_REQUEST_1, FRIEND_REQUEST_2
    ]
    
    public var users: AnyPublisher<[Domain.User], Never> { $_users.eraseToAnyPublisher() }
    @Published var _users: [Domain.User] = USERS
    
    public init() { }
    
    public func getUser(uid: String) -> Domain.User? {
        _users.first(where: { $0.uid == uid })
    }
    
    public func getUsers() -> [Domain.User] {
        _users
    }
    
    public func getFriends() -> [Domain.User] {
        _friends
    }
    
    public func getHistories(friendId: String) async throws -> [Domain.History] {
        HistoryRepositoryMock()._histories
    }
    
    public func getExercises(friendId: String) async throws -> [Domain.Exercise] {
        ExerciseRepositoryMock()._exercises
    }
    
    public func requestFriend(userId: String) async throws {
        
    }
    
    public func accept(request: Domain.FriendRequest) async throws {
        // delete request
        if let index = _requests.firstIndex(where: { $0.fromId == request.fromId }) {
            _requests.remove(at: index)
        }
        
        // add friend
        if let friend = _users.first(where: { $0.uid == request.fromId }) {
            _friends.append(friend)
        }
    }
    
    public func refuse(request: Domain.FriendRequest) async throws {
        // delete request
        if let index = _requests.firstIndex(where: { $0.fromId == request.fromId }) {
            _requests.remove(at: index)
        }
    }
    
    public func delete(friendId: String) async throws {
        if let index = _friends.firstIndex(where: { $0.uid == friendId }) {
            _friends.remove(at: index)
        }
    }
}
