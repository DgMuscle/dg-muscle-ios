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
            }
            
            ForEach(viewModel.historySections) { section in
                HistorySectionView(section: section, exerciseRepository: exerciseRepository, healthRepository: healthRepository)
            }
        }
        .padding()
        .scrollIndicators(.hidden)
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
