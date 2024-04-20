//
//  HistoryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    let historyRepository: HistoryRepositoryV2
    let heatmapRepository: HeatmapRepository
    let today: Date
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 60)
            
            Button {
                coordinator.main.selectHeatmapColor()
            } label: {
                WorkoutHeatMapView(viewModel: .init(historyRepository: historyRepository,
                                                    today: today,
                                                    heatmapRepository: heatmapRepository))
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
                    .padding(.bottom, 20)
            }
            
            if let user = viewModel.user {
                Button {
                    coordinator.main.setting()
                } label: {
                    HStack {
                        UserBoxView(user: user, descriptionLabel: "Go to setting")
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            
            Button {
                coordinator.history.historyForm(history: viewModel.findTodayExerciseHistory())
            } label: {
                WorkoutRectangleButton()
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
            }
            
            ForEach(viewModel.historySections) { section in
                HistorySectionView(section: section, 
                                   exerciseRepository: exerciseRepository,
                                   healthRepository: healthRepository) { history in
                    coordinator.history.historyForm(history: history)
                } deleteAction: { history in
                    viewModel.delete(history: history)
                } tapSectionHeader: {
                    coordinator.history.monthlySection(historySection: section)
                }
                .padding(.bottom, 40)
            }
            
            Spacer(minLength: 120)
        }
        .padding()
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240415")!
    
    let viewModel = HistoryViewModel(historyRepository: HistoryRepositoryV2Test(),
                                     healthRepository: HealthRepositoryTest(), 
                                     userRepository: UserRepositoryV2Test())
    
    return HistoryView(viewModel: viewModel,
                       exerciseRepository: ExerciseRepositoryV2Test(),
                       healthRepository: HealthRepositoryTest(),
                       historyRepository: HistoryRepositoryV2Test(), 
                       heatmapRepository: HeatmapRepositoryTest(),
                       today: today)
        .preferredColorScheme(.dark)
        .environmentObject(Coordinator(path: .constant(.init())))
}
