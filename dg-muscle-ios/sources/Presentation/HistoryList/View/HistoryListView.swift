//
//  HistoryListView.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import MockData
import HeatMap

public struct HistoryListView: View {
    @StateObject var viewModel: HistoryListViewModel
    
    public init(today: Date,
                historyRepository: any HistoryRepository,
                exerciseRepository: any ExerciseRepository,
                heatMapRepository: any HeatMapRepository) {
        _viewModel = .init(wrappedValue: .init(
            today: today,
            historyRepository: historyRepository,
            exerciseRepository: exerciseRepository,
            heatMapRepository: heatMapRepository)
        )
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 50)
                
                HeatMapView(heatMap: viewModel.heatMap, color: .green)
                    .padding(.bottom)
                
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
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240515")!
    
    return HistoryListView(today: date,
                    historyRepository: HistoryRepositoryMock(),
                    exerciseRepository: ExerciseRepositoryMock(),
                    heatMapRepository: HeatMapRepositoryMock())
    .preferredColorScheme(.dark)
}
