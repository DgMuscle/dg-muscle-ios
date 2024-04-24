//
//  FriendRepositoryImpl.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import Foundation
import Combine

final class FriendRepositoryImpl: FriendRepository {
    
    var friends: [Friend] { _friends }
    var friendsPublisher: AnyPublisher<[Friend], Never> {
        $_friends.eraseToAnyPublisher()
    }
    @Published private var _friends: [Friend] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    func fetchFriends() {
        Task {
            let friends: [Friend] = try await APIClient.shared.request(url: FunctionsURL.friend(.getfriends))
            _friends = friends
        }
    }
    
    private func bind() {
        UserRepositoryV2Live.shared.isLoginPublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { login in
                if login {
                    self.fetchFriends()
                } else {
                    self._friends = []
                }
            }
            .store(in: &cancellables)
    }
}
