//
//  HistoryListView.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import MockData

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
                Spacer(minLength: 150)
                ForEach(viewModel.historiesGroupedByMonth, id: \.self) { section in
                    Section {
                        VStack {
                            ForEach(section.histories, id: \.self) { history in
                                HistoryItemView(history: history)
                            }
                        }
                        .padding(.bottom)
                    } header: {
                        HStack {
                            Text(section.yearMonth).fontWeight(.black)
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HistoryListView(historyRepository: HistoryRepositoryMock(),
                    exerciseRepository: ExerciseRepositoryMock())
    .preferredColorScheme(.dark)
}
