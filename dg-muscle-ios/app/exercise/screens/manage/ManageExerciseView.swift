//
//  ManageExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ManageExerciseView: View {
    
    @StateObject var viewModel: ManageExerciseViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ScrollView {
            
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            ExerciseListV2View(viewModel: .init(exerciseRepository: viewModel.exerciseRepository)) { exercise in
                coordinator.exercise.edit(exercise: exercise)
            } addAction: {
                coordinator.exercise.step1()
            } deleteAction: { exercise in
                viewModel.delete(data: exercise)
            }
            
            if viewModel.isVisibleAddButton {
                Button {
                    coordinator.exercise.step1()
                } label: {
                    HStack {
                        Spacer()
                        Text("ADD EXERCISE")
                            .foregroundStyle(.white)
                            .fontWeight(.black)
                            
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LinearGradient(colors: [.blue, .indigo],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
                    )
                }
            }
        }
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.errorMessage)
        .padding()
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    coordinator.exercise.step1()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Manage Exercise")
    }
}

#Preview {
    return ManageExerciseView(viewModel: .init(exerciseRepository: ExerciseRepositoryV2Test()))
        .preferredColorScheme(.dark)
        .environmentObject(Coordinator(path: .constant(.init())))
}
