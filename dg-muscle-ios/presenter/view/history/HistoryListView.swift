//
//  HistoryListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HistoryListView: View {
    
    let today: Date
    let historyRepository: HistoryRepository
    
    @StateObject var viewModel: HistoryListViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 60)
            
            Button {
                coordinator.main.heatmapColor()
            } label: {
                HeatmapView(viewModel: .init(subscribeHeatmapUsecase: subscribeHeatmapUsecase,
                                             subscribeHeatmapColorUsecase: subscribeHeatmapColorUsecase))
            }
            .scrollTransition { effect, phase in
                effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
            }
            .padding(.bottom, 20)
            
            HStack {
                Button("start workout".capitalized) {
                    coordinator.history.historyForm(viewModel.todayHistory())
                }
                .fontWeight(.black)
                Spacer()
            }
            
            if let user = viewModel.user {
                Button {
                    coordinator.main.setting()
                } label: {
                    HStack {
                        UserBoxView2(user: user, descriptionLabel: "go to setting".capitalized)
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
    
    var subscribeHeatmapUsecase: SubscribeHeatmapUsecase {
        .init(historyRepository: historyRepository, today: today)
    }
    
    var subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase {
        .init(historyRepository: historyRepository)
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240415")!
    
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let userRepository: UserRepository = UserRepositoryTest()
    
    let viewModel: HistoryListViewModel = .init(subscribeGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                                subscribeMetaDatasMapUsecase: .init(healthRepository: healthRepository),
                                                subscribeUserUsecase: .init(userRepository: userRepository), 
                                                getTodayHistoryUsecase: .init(historyRepository: historyRepository, today: today), 
                                                deleteHistoryUsecase: .init(historyRepository: historyRepository))
    
    return HistoryListView(today: today, historyRepository: historyRepository, viewModel: viewModel)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
