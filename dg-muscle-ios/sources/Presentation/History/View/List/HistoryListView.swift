//
//  HistoryListView.swift
//  HistoryList
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import Domain
import MockData
import HistoryHeatMap

public struct HistoryListView: View {
    @StateObject var viewModel: HistoryListViewModel
    
    let tapHistory: ((_ historyId: String) -> ())?
    let tapHeatMap: (() -> ())?
    
    public init(
        today: Date,
        historyRepository: any HistoryRepository,
        exerciseRepository: any ExerciseRepository,
        heatMapRepository: any HeatMapRepository,
        userRepository: any UserRepository,
        tapHistory: ((_ historyId: String) -> ())?,
        tapHeatMap: (() -> ())?
    ) {
        _viewModel = .init(wrappedValue:
                .init(
                    today: today,
                    historyRepository: historyRepository,
                    exerciseRepository: exerciseRepository,
                    heatMapRepository: heatMapRepository,
                    userRepository: userRepository
                )
        )
        
        self.tapHistory = tapHistory
        self.tapHeatMap = tapHeatMap
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 50)
                
                Button {
                    tapHeatMap?()
                } label: {
                    HeatMapView(
                        heatMap: viewModel.heatMap,
                        color: viewModel.color
                    )
                }
                .padding(.bottom)
                
                ForEach(viewModel.historiesGroupedByMonth, id: \.self) { section in
                    Section {
                        VStack(spacing: 12) {
                            ForEach(section.histories, id: \.self) { history in
                                Button {
                                    tapHistory?(history.id)
                                } label: {
                                    HistoryItemView(history: history)
                                }
                            }
                        }
                        .padding(.bottom)
                    } header: {
                        HStack {
                            Text(section.yearMonth)
                                .font(.system(size: 20))
                                .fontWeight(.black)
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        tapHistory?(UUID().uuidString)
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundStyle(Color(uiColor: .systemBackground))
                            .background(
                                Circle()
                                    .fill(Color(uiColor: .label).opacity(0.4))
                            )
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240515")!
    
    return HistoryListView(today: date,
                           historyRepository: HistoryRepositoryMock(),
                           exerciseRepository: ExerciseRepositoryMock(),
                           heatMapRepository: HeatMapRepositoryMock(),
                           userRepository: UserRepositoryMock(),
                           tapHistory: nil,
                           tapHeatMap: nil)
    .preferredColorScheme(.dark)
}
