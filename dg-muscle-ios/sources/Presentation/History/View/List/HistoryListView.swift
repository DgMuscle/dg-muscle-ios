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
import Common

public struct HistoryListView: View {
    @StateObject var viewModel: HistoryListViewModel
    
    public init(
        today: Date,
        historyRepository: any HistoryRepository,
        exerciseRepository: any ExerciseRepository,
        heatMapRepository: any HeatMapRepository,
        userRepository: any UserRepository
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
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Button {
                    URLManager.shared.open(url: "dgmuscle://heatmapcolorselect")
                } label: {
                    HeatMapView(
                        heatMap: viewModel.heatMap,
                        color: viewModel.color
                    )
                }
                .padding(.bottom)
                
                if viewModel.historiesGroupedByMonth.isEmpty {
                    Text("First time DgMuscle?")
                    
                    Text("Swipe right to go to My Page")
                    
                    if viewModel.hasExercise == false {
                        Button("Generate your first exercise!") {
                            URLManager.shared.open(url: "dgmuscle://exercisemanage")
                        }
                    } else {
                        Button("Generate your first history!") {
                            URLManager.shared.open(url: "dgmuscle://history")
                        }
                    }
                }
                
                ForEach(viewModel.historiesGroupedByMonth, id: \.self) { section in
                    Section {
                        VStack(spacing: 12) {
                            ForEach(section.histories, id: \.self) { history in
                                Button {
                                    URLManager.shared.open(url: "dgmuscle://history?id=\(history.id)")
                                } label: {
                                    Common.HistoryItemView(history: history)
                                }
                                .buttonStyle(.plain)
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
                        URLManager.shared.open(url: "dgmuscle://history")
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
                           userRepository: UserRepositoryMock())
    .preferredColorScheme(.dark)
}
