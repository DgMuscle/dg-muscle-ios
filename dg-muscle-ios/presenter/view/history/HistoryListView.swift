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
    let exerciseRepository: ExerciseRepository
    let healthRepository: HealthRepositoryDomain
    
    @StateObject var viewModel: HistoryListViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 60)
            
            Button {
                coordinator.main.heatmapColor()
            } label: {
                HeatmapView(viewModel: .init(subscribeHeatmapUsecase: .init(historyRepository: historyRepository, today: today),
                                             subscribeHeatmapColorUsecase: .init(historyRepository: historyRepository)))
            }
            .scrollTransition { effect, phase in
                effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
            }
            .padding(.bottom, 20)
            
            Button {
                coordinator.history.historyForm(viewModel.todayHistory() ?? .init())
            } label: {
                RoundedGradationText(text: "START WORKOUT")
            }
            .scrollTransition { effect, phase in
                effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
            }
            .padding(.bottom)
            
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
            
            ForEach(viewModel.sections) { section in
                HistorySectionViewV2(section: section,
                                     tapHistory: tapHistory,
                                     deleteHistory: viewModel.delete,
                                     tapHeader: tapHeader,
                                     exerciseRepository: exerciseRepository,
                                     healthRepository: healthRepository,
                                     color: viewModel.heatmapColor)
            }
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
    
    private func tapHistory(history: HistoryV) {
        coordinator.history.historyForm(history)
    }
    
    private func tapHeader() {
        
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240415")!
    
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let userRepository: UserRepository = UserRepositoryTest()
    
    let viewModel: HistoryListViewModel = .init(subscribeGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                                subscribeMetaDatasMapUsecase: .init(healthRepository: healthRepository),
                                                subscribeUserUsecase: .init(userRepository: userRepository), 
                                                getTodayHistoryUsecase: .init(historyRepository: historyRepository, today: today), 
                                                deleteHistoryUsecase: .init(historyRepository: historyRepository),
                                                getHeatmapColorUsecase: .init(historyRepository: historyRepository),
                                                subscribeHeatmapColorUsecase: .init(historyRepository: historyRepository)
    )
    
    return HistoryListView(today: today, 
                           historyRepository: historyRepository,
                           exerciseRepository: exerciseRepository,
                           healthRepository: healthRepository,
                           viewModel: viewModel)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
