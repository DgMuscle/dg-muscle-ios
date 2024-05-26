//
//  SearchUsersViewModel.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import Foundation
import Domain
import Combine
import Common

final class SearchUsersViewModel: ObservableObject {
    @Published var users: [Common.User] = []
    @Published var query: String = ""
    
    private let searchUsersExceptForMyFriendsUsecase: SearchUsersExceptForMyFriendsUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        searchUsersExceptForMyFriendsUsecase = .init(
            friendRepository: friendRepository,
            userRepository: userRepository
        )
        
        bind()
    }
    
    private func bind() {
        $query
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({ [weak self] query in
                guard let self else { return [] }
                let domainUsers: [Domain.User] = searchUsersExceptForMyFriendsUsecase.implement(query: query)
                let users: [Common.User] = domainUsers.map({ .init(domain: $0) })
                return users
            })
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }
}
