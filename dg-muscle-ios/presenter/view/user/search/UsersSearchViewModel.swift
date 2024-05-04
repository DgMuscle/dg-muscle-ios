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
    @Published var loading: Bool = false
    @Published var success: Bool = false
    @Published var errorMessage: String?
     
    private let searchUsersByDisplayNameUsecase: SearchUsersByDisplayNameUsecase
    private let getMyFriendsUsecase: GetMyFriendsUsecase
    private let getUserUsecase: GetUserUsecase
    private let postFriendRequestUsecase: PostFriendRequestUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(searchUsersByDisplayNameUsecase: SearchUsersByDisplayNameUsecase,
         getMyFriendsUsecase: GetMyFriendsUsecase,
         getUserUsecase: GetUserUsecase,
         postFriendRequestUsecase: PostFriendRequestUsecase) {
        self.searchUsersByDisplayNameUsecase = searchUsersByDisplayNameUsecase
        self.getMyFriendsUsecase = getMyFriendsUsecase
        self.getUserUsecase = getUserUsecase
        self.postFriendRequestUsecase = postFriendRequestUsecase
        bind()
    }
    
    @MainActor
    func sendRequest(user: UserV) {
        Task {
            guard loading == false else { return }
            loading = true
            do {
                try await postFriendRequestUsecase.implement(userId: user.uid)
                success.toggle()
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
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
        let me = getUserUsecase.implement()
        var searchedUsers: [UserV] = searchUsersByDisplayNameUsecase
            .implement(displayName: query)
            .map({ .init(from: $0) })
            .filter({ $0.uid != me?.uid })
        
        let myFriends = getMyFriendsUsecase.implement()
        
        for friend in myFriends {
            if let index = searchedUsers.firstIndex(where: { $0.uid == friend.uid }) {
                searchedUsers[index].isMyFriend = true
            }
        }
        
        return searchedUsers
    }
}
