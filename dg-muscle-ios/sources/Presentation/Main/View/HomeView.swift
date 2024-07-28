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
    
    let historyListFactory: (Date) -> HistoryListView
    let myViewFactory: () -> MyView
    
    public init(today: Date,
                historyListFactory: @escaping (Date) -> HistoryListView,
                myViewFactory: @escaping () -> MyView) {
        self.today = today
        self.historyListFactory = historyListFactory
        self.myViewFactory = myViewFactory
    }
    
    public var body: some View {
        ZStack {
            Rectangle().fill(Color(uiColor: .systemBackground))
            TabView {
                historyListFactory(today)
                myViewFactory()
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240515")!
    
    let historyRepository = HistoryRepositoryMock()
    let exerciseRepository = ExerciseRepositoryMock()
    let heatMapRepository = HeatMapRepositoryMock()
    let userRepository = UserRepositoryMock()
    let logRepository = LogRepositoryMock()
    
    return HomeView(
        today: today,
        historyListFactory: {
            today in HistoryListView(
                today: today,
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                heatMapRepository: heatMapRepository,
                userRepository: userRepository
            )
        },
        myViewFactory: {
            MyView(
                userRepository: userRepository,
                logRepository: logRepository
            )
        }
    )
    .preferredColorScheme(.dark)
}
