//
//  ContentViewV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ContentViewV2: View {
    
    let viewModel: HistoryViewModel
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    
    var body: some View {
        HistoryView(viewModel: viewModel,
                    exerciseRepository: exerciseRepository,
                    healthRepository: healthRepository)
    }
}

#Preview {
    
    let historyRepository = HistoryRepositoryV2Test()
    let healthRepository = HealthRepositoryTest()
    let userRepository = UserRepositoryV2Test()
    let exerciseRepository = ExerciseRepositoryV2Test()
    
    let historyViewModel = HistoryViewModel(historyRepository: historyRepository,
                                            healthRepository: healthRepository,
                                            userRepository: userRepository)
    
    return ContentViewV2(viewModel: historyViewModel,
                         exerciseRepository: exerciseRepository,
                         healthRepository: healthRepository)
        .preferredColorScheme(.dark)
}
