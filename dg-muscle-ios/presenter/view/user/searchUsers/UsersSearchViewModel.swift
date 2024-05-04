//
//  UsersSearchViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import Combine

final class UsersSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var searchedUsers: [UserV] = []
    
    private let searchUsersByDisplayNameUsecase: SearchUsersByDisplayNameUsecase
    private let getMyFriendsUsecase: GetMyFriendsUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(searchUsersByDisplayNameUsecase: SearchUsersByDisplayNameUsecase,
         getMyFriendsUsecase: GetMyFriendsUsecase) {
        self.searchUsersByDisplayNameUsecase = searchUsersByDisplayNameUsecase
        self.getMyFriendsUsecase = getMyFriendsUsecase
        bind()
    }
    
    func removeQuery() {
        query = ""
    }
    
    private func bind() {
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self else { return }
                searchedUsers = configureSearchedUsers(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func configureSearchedUsers(query: String) -> [UserV] {
        var searchedUsers: [UserV] = searchUsersByDisplayNameUsecase
            .implement(displayName: query)
            .map({ .init(from: $0) })
        
        let myFriends = getMyFriendsUsecase.implement()
        
        for friend in myFriends {
            if let index = searchedUsers.firstIndex(where: { $0.uid == friend.uid }) {
                searchedUsers[index].isMyFriend = true
            }
        }
        
        return searchedUsers
    }
}
