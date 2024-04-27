//
//  EditExerciseView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/14/24.
//

import SwiftUI

struct EditExerciseView: View {
    
    @StateObject var viewModel: EditExerciseViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                if let errorMessage = viewModel.errorMessage {
                    BannerErrorMessageView(errorMessage: errorMessage)
                }
                
                if viewModel.loading {
                    BannerLoadingView(loading: $viewModel.loading)
                }
                
                TextField("Exercise Name", text: $viewModel.exercise.name)
                    .fontWeight(.black)
                    .padding(.bottom)
                
                Divider()
                
                ExercisePartsSelectionForm(viewModel: .init(parts: $viewModel.exercise.parts))
                    .padding(.bottom)
                
                Toggle("Favorite", isOn: $viewModel.exercise.favorite)
                    .fontWeight(.black)
                    .padding(.bottom, 80)
                
                Button {
                    viewModel.update()
                } label: {
                    VStack {
                        Text("Update")
                            .fontWeight(.black)
                            .foregroundStyle(Color(uiColor: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                        
                        Divider()
                    }
                }
            }
            .padding()
            .animation(.default, value: viewModel.loading)
            .animation(.default, value: viewModel.errorMessage)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    
    let exercise = Exercise(id: "1", name: "Squat", parts: [.leg], favorite: true, order: 0, createdAt: nil)
    
    let viewModel = EditExerciseViewModel(exercise: exercise, exerciseRepository: ExerciseRepositoryV2Test(), completeAction: nil)
    
    return EditExerciseView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
