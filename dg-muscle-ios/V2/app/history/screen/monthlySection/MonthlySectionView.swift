//
//  MonthlySectionView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/19/24.
//

import SwiftUI

struct MonthlySectionView: View {
    
    @StateObject var viewModel: MonthlySectionViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    
    let histories: [ExerciseHistorySection.History] =
    HistoryRepositoryV2Test().histories.map({ .init(exercise: $0, metadata: nil) })
    let sectionData = ExerciseHistorySection(histories: histories)
    
    let viewModel = MonthlySectionViewModel(exerciseHistorySection: sectionData,
                                            exerciseRepository: ExerciseRepositoryV2Test())
    
    return MonthlySectionView(viewModel: viewModel).preferredColorScheme(.dark)
}
