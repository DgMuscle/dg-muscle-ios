//
//  HistoryDetailView.swift
//  Friend
//
//  Created by 신동규 on 6/15/24.
//

import SwiftUI
import Domain
import MockData
import MapKit

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
            
            if let run = viewModel.history?.run {
                RunSectionView(run: run)
            }
            
            Text("Total Volume is ") +
            Text("\(viewModel.totalVolume)").foregroundStyle(viewModel.color)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    
    let history = HISTORIES[4]
    
    let view = HistoryDetailView(
        friendRepository: FriendRepositoryMock(),
        friendId: USER_DG.uid,
        historyId: history.id
    )
    
    return view.preferredColorScheme(.dark)
}
