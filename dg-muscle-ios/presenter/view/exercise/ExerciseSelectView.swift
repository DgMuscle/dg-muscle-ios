//
//  ExerciseSelectView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseSelectView: View {
    let exerciseRepository: ExerciseRepository
    let select: ((ExerciseV) -> ())?
    let moveToExerciseManage: (() -> ())?
    
    var body: some View {
        ScrollView {
            VStack {
                ExerciseSectionsView(viewModel: .init(
                    subscribeGroupedExercisesUsecase: .init(exerciseRepository: exerciseRepository)
                ),
                                     tapExercise: select,
                                     deleteAction: nil)
                .padding(.bottom)
                
                Button {
                    moveToExerciseManage?()
                } label: {
                    RoundedGradationText(text: "MOVE TO MANAGE")
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    return ExerciseSelectView(exerciseRepository: exerciseRepository,
                              select: nil,
                              moveToExerciseManage: nil)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
