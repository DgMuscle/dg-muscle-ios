//
//  HistoryListView.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import Combine

public struct HistoryListView: View {
    @StateObject var viewModel: HistoryListViewModel
    
    public init(historyRepository: any HistoryRepository, 
                exerciseRepository: any ExerciseRepository) {
        _viewModel = .init(wrappedValue: .init(historyRepository: historyRepository,
                                               exerciseRepository: exerciseRepository))
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.historiesGroupedByMonth, id: \.self) { section in
                    Section(section.yearMonth) {
                        ForEach(section.histories, id: \.self) { history in
                            HistoryItemView(history: history)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
    }
}
