//
//  SearchUsersView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import Domain
import MockData
import Common

struct SearchUsersView: View {
    
    @StateObject var viewModel: SearchUsersViewModel
    @State var selectedUser: Common.User?
    
    init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository,
                                               userRepository: userRepository))
    }
    
    var body: some View {
        List {
            
            if let status = viewModel.status {
                switch status {
                case .loading:
                    Common.StatusView(status: status)
                case .success, .error:
                    Common.StatusView(status: status)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                viewModel.status = nil
                            }
                        }
                }
                
                
            }
            
            TextField("Search users by display name", text: $viewModel.query)
            
            Section("Searched") {
                ForEach(viewModel.users, id: \.self) { user in
                    Button {
                        selectedUser = user
                    } label: {
                        FriendListItemView(friend: .init(domain: user.domain))
                    }
                }
            }
        }
        .animation(.default, value: viewModel.status)
        .scrollIndicators(.hidden)
        .sheet(item: $selectedUser) { user in
            RequestFriendView(user: user) { userId in
                viewModel.requestFriend(userId: userId)
                selectedUser = nil
            }
            .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    return SearchUsersView(
        friendRepository: FriendRepositoryMock(),
        userRepository: UserRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
