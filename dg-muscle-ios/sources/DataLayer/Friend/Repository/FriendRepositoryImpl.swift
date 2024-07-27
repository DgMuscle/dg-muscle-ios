//
//  FriendRepositoryImpl.swift
//  DataLayer
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Domain
import Combine

public final class FriendRepositoryImpl: FriendRepository {
    public static let shared = FriendRepositoryImpl()
    
    public var friends: AnyPublisher<[Domain.User], Never> { $_friends.eraseToAnyPublisher() }
    @Published var _friends: [Domain.User] = []
    
    public var requests: AnyPublisher<[Domain.FriendRequest], Never> { $_requests.eraseToAnyPublisher() }
    @Published var _requests: [Domain.FriendRequest] = []
    
    public var users: AnyPublisher<[Domain.User], Never> { $_users.eraseToAnyPublisher() }
    @Published var _users: [Domain.User] = []
    
    private var friendsHistories: [String: [Domain.History]] = [:]
    private var friendsExercises: [String: [Domain.Exercise]] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    private init() {
        Task {
            _users = try await getUsersFromServer()
            bind()
        }
    }
    
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
        if let histories = friendsHistories[friendId] {
            return histories
        } else {
            let url = FunctionsURL.history(.getfriendhistories) + "?friendId=\(friendId)"
            let histories: [History] = try await APIClient.shared.request(url: url)
            let domain = histories.map({ $0.domain })
            friendsHistories[friendId] = domain
            return domain
        }
    }
    
    public func getExercises(friendId: String) async throws -> [Domain.Exercise] {
        
        if let exercises = friendsExercises[friendId] {
            return exercises
        }
        
        let url = FunctionsURL.exercise(.getexercisesfromuid) + "?uid=\(friendId)"
        let exercises: [Exercise] = try await APIClient.shared.request(url: url)
        let domain: [Domain.Exercise] = exercises.map({ $0.domain })
        
        friendsExercises[friendId] = domain
        
        return domain
    }
    
    public func requestFriend(userId: String) async throws {
        
        struct Body: Codable {
            let toId: String
        }
        
        let body = Body(toId: userId)
        let url = FunctionsURL.friend(.postrequest)
        
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: body
        )
    }
    
    public func accept(request: Domain.FriendRequest) async throws {
        struct Body: Codable {
            let friendId: String
        }
        
        // remove requests
        if let index = _requests.firstIndex(where: { $0.fromId == request.fromId }) {
            _requests.remove(at: index)
        }
        
        // add friend
        if let friend = _users.first(where: { $0.uid == request.fromId }) {
            _friends.append(friend)
        }

        // api
        let url = FunctionsURL.friend(.post)
        let body = Body(friendId: request.fromId)
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: body
        )
    }
    
    public func refuse(request: Domain.FriendRequest) async throws {
        struct Body: Codable {
            let deleteId: String
        }
        
        // remove requests
        if let index = _requests.firstIndex(where: { $0.fromId == request.fromId }) {
            _requests.remove(at: index)
        }
        
        // api
        let url = FunctionsURL.friend(.deleterequest)
        let body = Body(deleteId: request.fromId)
        let _: DataResponse = try await APIClient.shared.request(
            method: .delete,
            url: url,
            body: body
        )
    }
    
    public func fetch() {
        Task {
            async let getFriendsTask = self.getFriendsFromServer()
            async let getRequestsTask = self.getRequestsFromServer()
            
            let friends = try await getFriendsTask
            let requests = try await getRequestsTask
              
            self._friends = friends
            self._requests = requests
            
            let friendIds = friends.map({ $0.uid })
            
            for id in friendIds {
                Task {
                    try? await getHistories(friendId: id)
                }
            }
        }
    }
    
    public func delete(friendId: String) async throws {
        
        if let index = _friends.firstIndex(where: { $0.uid == friendId }) {
            _friends.remove(at: index)
        }
        
        let url = FunctionsURL.friend(.delete)
        
        struct body: Codable {
            let friendId: String
        }
        
        let _: DataResponse = try await APIClient.shared.request(
            method: .delete,
            url: url,
            body: body(friendId: friendId)
        )
    }
    
    private func bind() {
        // fetch friends
        // fetch requests
        
        UserRepositoryImpl
            .shared
            .$isLogin
            .removeDuplicates()
            .delay(for: 0.5, scheduler: DispatchQueue.main)
            .filter({ $0 })
            .sink { _ in
                self.fetch()
            }
            .store(in: &cancellables)
    }
    
    private func getUsersFromServer() async throws -> [Domain.User] {
        let url = FunctionsURL.user(.getprofiles)
        var data: [UserData] = try await APIClient.shared.request(url: url)
        data = data
            .filter({ $0.deleted != true })
        return data.map({ $0.domain })
    }
    
    private func getFriendsFromServer() async throws -> [Domain.User] {
        let url = FunctionsURL.friend(.getfriends)
        let data: [Friend] = try await APIClient.shared.request(url: url)
        let friendsIds = data.map({ $0.uid })
        var friends = _users
        friends = friends
            .filter({ friendsIds.contains($0.uid) })
        return friends
    }
    
    private func getRequestsFromServer() async throws -> [Domain.FriendRequest] {
        let url = FunctionsURL.friend(.getrequests)
        let data: [FriendRequest] = try await APIClient.shared.request(url: url)
        return data.map({ $0.domain })
    }
}
