//
//  FriendListView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import Domain
import MockData

struct FriendListView: View {
    
    @StateObject var viewModel: FriendListViewModel
    @State private var selectedFriend: Friend?
    
    init(friendRepository: FriendRepository) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.friends, id: \.self) { friend in
                FriendListItemView(friend: friend)
                    .onTapGesture {
                        selectedFriend = friend
                    }
                    .contextMenu {
                        Button("delete") {
                            viewModel.delete(friendId: friend.id)
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
        .fullScreenCover(item: $selectedFriend) { friend in
            FriendProfileView(friend: friend, selectedFriend: $selectedFriend)
        }
    }
}

#Preview {
    return FriendListView(friendRepository: FriendRepositoryMock())
        .preferredColorScheme(.dark)
}
