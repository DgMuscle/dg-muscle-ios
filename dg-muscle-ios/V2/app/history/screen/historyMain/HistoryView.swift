//
//  HistoryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    @Binding var paths: NavigationPath
    
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    let historyRepository: HistoryRepositoryV2
    let today: Date
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 60)
            
            WorkoutHeatMapView(viewModel: .init(historyRepository: historyRepository, today: today))
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
                .padding(.bottom, 20)
            
            if let user = viewModel.user {
                Button {
                    paths.append(MainNavigation(name: .setting))
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
                paths.append(HistoryNavigation(name: .historyForm,
                                               historyForForm: viewModel.findTodayExerciseHistory()))
                
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
                    paths.append(HistoryNavigation(name: .historyForm, historyForForm: history))
                } deleteAction: { history in
                    viewModel.delete(history: history)
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
    
    return HistoryView(viewModel: viewModel, paths: .constant(.init()),
                       exerciseRepository: ExerciseRepositoryV2Test(),
                       healthRepository: HealthRepositoryTest(),
                       historyRepository: HistoryRepositoryV2Test(),
                       today: today)
        .preferredColorScheme(.dark)
}
