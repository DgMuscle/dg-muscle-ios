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
    
    @State private var showProfileView: Bool = false
    
    let today: Date
    let historyListFactory: (Date) -> HistoryListView
    let myViewFactory: ((() -> Void)?) -> MyView
    let myProfileViewFactory: (Binding<Bool>) -> MyProfileView
    
    public init(
        today: Date,
        historyListFactory: @escaping (Date) -> HistoryListView,
        myViewFactory: @escaping ((() -> Void)?) -> MyView,
        myProfileViewFactory: @escaping (Binding<Bool>) -> MyProfileView
    ) {
        self.today = today
        self.historyListFactory = historyListFactory
        self.myViewFactory = myViewFactory
        self.myProfileViewFactory = myProfileViewFactory
    }
    
    public var body: some View {
        ZStack {
            Rectangle().fill(Color(uiColor: .systemBackground))
            TabView {
                historyListFactory(today)
                myViewFactory {
                    if showProfileView == false {
                        showProfileView = true 
                    }
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: showProfileView ? .never : .always))
            .indexViewStyle(.page(backgroundDisplayMode: showProfileView ? .never : .always))
            
            if showProfileView {
                myProfileViewFactory($showProfileView)
            }
        }
        .animation(.default, value: showProfileView)
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
        myViewFactory: { _ in 
            MyView(
                userRepository: userRepository,
                logRepository: logRepository, 
                presentProfileViewAction: nil
            )
        },
        myProfileViewFactory: {_ in 
            MyProfileView(
                shows: .constant(false),
                userRepository: userRepository, 
                myProfileEditFactory: {
                    MyProfileEditView(userRepository: userRepository)
                }
            )
        }
    )
    .preferredColorScheme(.dark)
}
