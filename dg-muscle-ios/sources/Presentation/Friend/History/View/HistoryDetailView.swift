//
//  HistoryDetailView.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import Domain
import MockData

public struct HistoryDetailView: View {
    
    @StateObject var viewModel: HistoryDetailViewModel
    
    public init(
        friendRepository: any FriendRepository,
        friendId: String,
        historyId: String
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                friendRepository: friendRepository,
                friendId: friendId,
                historyId: historyId
            )
        )
    }
    
    public var body: some View {
        Text("HistoryDetailView")
    }
}

#Preview {
    let view = HistoryDetailView(
        friendRepository: FriendRepositoryMock(),
        friendId: USER_DG.uid,
        historyId: HISTORY_1.id
    )
    
    return view.preferredColorScheme(.dark)
}
