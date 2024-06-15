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
        List {
            if let history = viewModel.history {
                ForEach(history.records, id: \.self) { record in
                    RecordSectionView(record: record, color: viewModel.color)
                }
            } else {
                Text("Can't find data")
            }
            
            Text("Total Volume is ") +
            Text("\(viewModel.totalVolume)").foregroundStyle(viewModel.color)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let view = HistoryDetailView(
        friendRepository: FriendRepositoryMock(),
        friendId: USER_DG.uid,
        historyId: HISTORY_4.id
    )
    
    return view.preferredColorScheme(.dark)
}
