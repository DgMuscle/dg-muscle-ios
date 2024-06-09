//
//  FriendMainView.swift
//  Friend
//
//  Created by 신동규 on 6/9/24.
//

import SwiftUI
import Domain
import MockData

public struct FriendMainView: View {
    
    private let friendRepository: FriendRepository
    private let userRepository: UserRepository
    
    @State private var page: Page = .friend
    
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
    }
    
    public var body: some View {
        TabView(selection: $page) {
            FriendListView(friendRepository: friendRepository)
            
            SearchUsersView(
                friendRepository: friendRepository,
                userRepository: userRepository
            )
            
            RequestListView(
                friendRepository: friendRepository,
                userRepository: userRepository
            )
        }
        .tabViewStyle(.page)
        .navigationTitle("Friend")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension FriendMainView {
    enum Page: Hashable {
        case friend
        case search
        case request
    }
}

#Preview {
    return NavigationStack {
        FriendMainView(
            friendRepository: FriendRepositoryMock(),
            userRepository: UserRepositoryMock()
        )
        .preferredColorScheme(.dark)
    }
}
