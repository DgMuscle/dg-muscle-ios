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
    @State var selectedFriend: Friend?
    
    @StateObject var viewModel: FriendMainViewModel
    
    public init(
        friendRepository: FriendRepository,
        userRepository: UserRepository,
        page: PageAnchorView.Page
    ) {
        self.friendRepository = friendRepository
        self.userRepository = userRepository
        self.page = page
        self._viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
    }
    
    public var body: some View {
        ZStack {
            VStack {
                PageAnchorView(
                    page: $page,
                    friendRepository: friendRepository
                )
                
                if viewModel.loading {
                    ProgressView()
                }
                
                TabView(selection: $page) {
                    FriendListView(
                        friendRepository: friendRepository,
                        selectedFriend: $selectedFriend
                    )
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
            .animation(.default, value: viewModel.loading)
            
            if let selectedFriend {
                FriendProfileView(friend: selectedFriend, selectedFriend: $selectedFriend)
            }
        }
        .navigationBarBackButtonHidden(selectedFriend != nil)
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
