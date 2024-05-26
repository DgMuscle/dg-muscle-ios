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
    
    init(friendRepository: FriendRepository) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.friends, id: \.self) { friend in
                FriendListItemView(friend: friend)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    return FriendListView(friendRepository: FriendRepositoryMock())
        .preferredColorScheme(.dark)
}
