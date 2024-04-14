//
//  ManageExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct ManageExerciseView: View {
    
    @StateObject var viewModel: ManageExerciseViewModel
    @Binding var paths: NavigationPath
    
    
    var body: some View {
        ScrollView {
            
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            ExerciseListV2View(viewModel: .init(exerciseRepository: viewModel.exerciseRepository)) { exercise in
                paths.append(ExerciseNavigation(name: .edit, editExercise: exercise))
            } addAction: {
                paths.append(ExerciseNavigation(name: .step1))
                
            } deleteAction: { exercise in
                viewModel.delete(data: exercise)
            }
            
        }
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.errorMessage)
        .padding()
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    paths.append(ExerciseNavigation(name: .step1))
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    return ManageExerciseView(viewModel: .init(exerciseRepository: ExerciseRepositoryV2Test()), paths: .constant(.init()))
        .preferredColorScheme(.dark)
}
