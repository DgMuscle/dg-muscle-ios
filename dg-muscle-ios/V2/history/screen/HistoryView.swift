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
            ForEach(viewModel.historySections) { section in
                HistorySectionView(section: section, exerciseRepository: exerciseRepository, healthRepository: healthRepository)
            }
        }
        .padding()
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let viewModel = HistoryViewModel(historyRepository: HistoryRepositoryV2Test(), healthRepository: HealthRepositoryTest())
    
    return HistoryView(viewModel: viewModel, exerciseRepository: ExerciseRepositoryV2Test(), healthRepository: HealthRepositoryTest())
        .preferredColorScheme(.dark)
}
