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
        friendRepository: any FriendRepository
    ) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository))
    }
    
    public var body: some View {
        Text("FriendHistoryView")
    }
}

#Preview {
    return FriendHistoryView(
        friendRepository: FriendRepositoryMock()
    ).preferredColorScheme(
        .dark
    )
}
