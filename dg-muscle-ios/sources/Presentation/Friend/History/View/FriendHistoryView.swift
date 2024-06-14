//
//  FriendHistoryView.swift
//  Friend
//
//  Created by Donggyu Shin on 6/14/24.
//

import SwiftUI
import Domain
import MockData

public struct FriendHistoryView: View {
    
    @StateObject var viewModel: FriendHistoryViewModel
    
    public init(
        friendRepository: any FriendRepository,
        friendId: String
    ) {
        _viewModel = .init(wrappedValue: .init(
            friendRepository: friendRepository,
            friendId: friendId
        ))
    }
    
    public var body: some View {
        Text("FriendHistoryView")
    }
}

#Preview {
    return FriendHistoryView(
        friendRepository: FriendRepositoryMock(),
        friendId: ""
    ).preferredColorScheme(
        .dark
    )
}
