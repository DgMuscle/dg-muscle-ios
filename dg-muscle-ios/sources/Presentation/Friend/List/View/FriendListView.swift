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
    @Binding var selectedFriend: Friend?
    
    init(
        friendRepository: FriendRepository,
        selectedFriend: Binding<Friend?>
    ) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
        _selectedFriend = selectedFriend
    }
    
    var body: some View {
        List {
            ForEach(viewModel.friends, id: \.self) { friend in
                FriendListItemView(friend: friend)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if selectedFriend == nil {
                            selectedFriend = friend
                        }
                    }
                    .contextMenu {
                        Button("delete") {
                            viewModel.delete(friendId: friend.id)
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return FriendListView(
        friendRepository: FriendRepositoryMock(),
        selectedFriend: .constant(nil)
    )
        .preferredColorScheme(.dark)
}
