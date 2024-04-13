//
//  HistoryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    
    var body: some View {
        ScrollView {
            
            Spacer(minLength: 60)
            
            if let user = viewModel.user {
                Button {
                    print("Go to setting")
                } label: {
                    HStack {
                        UserBoxView(user: user)
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }
            }
            
            ForEach(viewModel.historySections) { section in
                HistorySectionView(section: section, exerciseRepository: exerciseRepository, healthRepository: healthRepository)
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
            }
            
            Spacer(minLength: 120)
        }
        .padding()
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    let viewModel = HistoryViewModel(historyRepository: HistoryRepositoryV2Test(),
                                     healthRepository: HealthRepositoryTest(), 
                                     userRepository: UserRepositoryV2Test())
    
    return HistoryView(viewModel: viewModel, 
                       exerciseRepository: ExerciseRepositoryV2Test(),
                       healthRepository: HealthRepositoryTest())
        .preferredColorScheme(.dark)
}
