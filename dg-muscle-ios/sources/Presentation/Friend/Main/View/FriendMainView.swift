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
    
    @State private var page: PageAnchorView.Page = .friend
    
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
    }
    
    public var body: some View {
        
        VStack {
            PageAnchorView(page: $page)
            TabView(selection: $page) {
                FriendListView(friendRepository: friendRepository)
                    .tag(PageAnchorView.Page.friend)
                
                SearchUsersView(
                    friendRepository: friendRepository,
                    userRepository: userRepository
                )
                .tag(PageAnchorView.Page.search)
                
                RequestListView(
                    friendRepository: friendRepository,
                    userRepository: userRepository
                )
                .tag(PageAnchorView.Page.request)
            }
            .tabViewStyle(.page)
        }
        .animation(.default, value: page)
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
