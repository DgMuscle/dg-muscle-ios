//
//  FriendsSearchView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/24/24.
//

import SwiftUI

struct FriendsSearchView: View {
    
    @StateObject var viewModel: FriendsSearchViewModel
    
    var body: some View {
        VStack {
            FriendSearchTextField(text: $viewModel.query)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.searchedUsers, id: \.self) { user in
                        FriendSearchUserView(user: user) {
                            viewModel.requestFriend(user: user)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    
    let viewModel: FriendsSearchViewModel = .init(userRepository: UserRepositoryV2Test(),
                                                  friendRepository: FriendRepositoryTest())
    
    return FriendsSearchView(viewModel: viewModel).preferredColorScheme(.dark)
}
