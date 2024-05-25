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
    
    private var cancellables = Set<AnyCancellable>()
    private init() {
        Task {
            _users = try await getUsersFromServer()
        }
        
        bind()
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
                Task {
                    async let getFriendsTask = self.getFriendsFromServer()
                    async let getRequestsTask = self.getRequestsFromServer()
                    
                    let friends = try await getFriendsTask
                    let requests = try await getRequestsTask
                      
                    self._friends = friends
                    self._requests = requests
                }
            }
            .store(in: &cancellables)
    }
    
    private func getUsersFromServer() async throws -> [Domain.User] {
        let url = FunctionsURL.user(.getprofiles)
        let data: [UserData] = try await APIClient.shared.request(url: url)
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
