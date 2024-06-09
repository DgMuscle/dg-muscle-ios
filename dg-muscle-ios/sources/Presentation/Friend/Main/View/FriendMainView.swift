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
    
    @State var page: PageAnchorView.Page
    
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository,
        page: PageAnchorView.Page
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
        self.page = page
    }
    
    public var body: some View {
        
        VStack {
            PageAnchorView(
                page: $page,
                friendRepository: friendRepository
            )
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
            userRepository: UserRepositoryMock(), 
            page: .friend
        )
        .preferredColorScheme(.dark)
    }
}
