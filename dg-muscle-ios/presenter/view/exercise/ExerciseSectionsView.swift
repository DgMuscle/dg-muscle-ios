//
//  ExerciseSectionsView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseSectionsView: View {
    @StateObject var viewModel: ExerciseSectionsViewModel
    
    let tapExercise: ((ExerciseV) -> ())?
    
    var body: some View {
        VStack {
            ForEach(viewModel.sections) { section in
                ExerciseSectionView(section: section, tapExercise: tapExercise)
                    .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let viewModel: ExerciseSectionsViewModel = .init(subscribeGroupedExercisesUsecase: .init(exerciseRepository: exerciseRepository))
    
    return ExerciseSectionsView(viewModel: viewModel,
                         tapExercise: nil)
    .preferredColorScheme(.dark)
}
