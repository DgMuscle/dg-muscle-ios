//
//  ExerciseManageView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseManageView: View {
    let exerciseRepository: ExerciseRepository
    @EnvironmentObject var coordinator: CoordinatorV2
    @StateObject var viewModel: ExerciseManageViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ExerciseSectionsView(viewModel: .init(
                    subscribeGroupedExercisesUsecase: .init(exerciseRepository: exerciseRepository)
                ),
                                     tapExercise: edit,
                                     deleteAction: delete)
                
                Button {
                    coordinator.exercise.add1()
                } label: {
                    RoundedGradationText(text: "ADD EXERCISE")
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.exercise.add1()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Manage Exercise")
    }
    
    func edit(exercise: ExerciseV) {
        coordinator.exercise.edit(exercise: exercise)
    }
    
    func delete(exercise: ExerciseV) {
        viewModel.delete(exercise: exercise)
    }
}

#Preview {
    
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let viewModel: ExerciseManageViewModel = .init(deleteExerciseUsecase: .init(exerciseRepository: exerciseRepository))
    
    return ExerciseManageView(exerciseRepository: exerciseRepository,
                       viewModel: viewModel)
    .environmentObject(CoordinatorV2(path: .constant(.init())))
    .preferredColorScheme(.dark)
}
