//
//  LogsView.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import SwiftUI
import Domain
import MockData

public struct LogsView: View {
    
    @StateObject var viewModel: LogsViewModel
    
    public init(
        logRepository: LogRepository,
        friendRepository: FriendRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                logRepository: logRepository,
                friendRepository: friendRepository
            )
        )
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.logs, id: \.self) { log in
                    Text(log.message)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    LogsView(
        logRepository: LogRepositoryMock(),
        friendRepository: FriendRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
