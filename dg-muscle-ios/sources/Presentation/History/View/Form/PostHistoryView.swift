//
//  PostHistoryView.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import SwiftUI
import Domain
import MockData

public struct PostHistoryView: View {
    
    @StateObject var viewModel: PostHistoryViewModel
    
    public init(
        historyRepository: HistoryRepository,
        exerciseRepository: ExerciseRepository,
        history: Domain.History?
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                historyRepository: historyRepository, 
                exerciseRepository: exerciseRepository,
                history: history
            )
        )
    }
    
    public var body: some View {
        Text("PostHistoryView")
    }
}

#Preview {
    return PostHistoryView(
        historyRepository: HistoryRepositoryMock(),
        exerciseRepository: ExerciseRepositoryMock(),
        history: HISTORY_1
    )
    .preferredColorScheme(.dark)
}
