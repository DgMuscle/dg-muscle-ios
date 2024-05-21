//
//  HomeView.swift
//  Presentation
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI
import History
import My
import Domain
import MockData

public struct HomeView: View {
    
    let today: Date
    let historyRepository: HistoryRepository
    let exerciseRepository: ExerciseRepository
    let heatMapRepository: HeatMapRepository
    let userRepository: UserRepository
    
    public init(today: Date,
                historyRepository: HistoryRepository,
                exerciseRepository: ExerciseRepository,
                heatMapRepository: HeatMapRepository,
                userRepository: UserRepository) {
        self.today = today
        self.historyRepository = historyRepository
        self.exerciseRepository = exerciseRepository
        self.heatMapRepository = heatMapRepository
        self.userRepository = userRepository
    }
    
    public var body: some View {
        TabView {
            HistoryListView(today: today,
                            historyRepository: historyRepository,
                            exerciseRepository: exerciseRepository,
                            heatMapRepository: heatMapRepository,
                            userRepository: userRepository) { historyId in
                print("historyId(\(historyId) is tapped")
            } tapHeatMap: {
                coordinator?.heatMapColorSelectView()
            }
            
            MyView(
                userRepository: userRepository) {
                    print("tap exercise")
                } tapProfileListItem: {
                    print("tap profile")
                }

        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240515")!
    
    return HomeView(today: today,
             historyRepository: HistoryRepositoryMock(),
             exerciseRepository: ExerciseRepositoryMock(),
             heatMapRepository: HeatMapRepositoryMock(),
             userRepository: UserRepositoryMock())
    .preferredColorScheme(.dark)
}