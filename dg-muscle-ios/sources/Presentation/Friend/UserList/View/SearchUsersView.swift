//
//  SearchUsersView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import Domain
import MockData

struct SearchUsersView: View {
    
    @StateObject var viewModel: SearchUsersViewModel
    
    init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository,
                                               userRepository: userRepository))
    }
    
    var body: some View {
        List {
            TextField("Search users by display name", text: $viewModel.query)
            
            Section("Searched") {
                ForEach(viewModel.users, id: \.self) { user in
                    FriendListItemView(friend: .init(domain: user.domain))
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return SearchUsersView(
        friendRepository: FriendRepositoryMock(),
        userRepository: UserRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
