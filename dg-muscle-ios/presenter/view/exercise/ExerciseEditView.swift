//
//  ExerciseEditView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseEditView: View {
    
    @StateObject var viewModel: ExerciseEditViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                TextField("Exercise Name", text: $viewModel.name)
                    .fontWeight(.black)
                    .padding(.bottom)
                
                Divider()
                
                ExercisePartsSectionView(viewModel: .init(parts: $viewModel.parts))
                    .padding(.bottom)
                
                Toggle("Favorite", isOn: $viewModel.favorite)
                    .fontWeight(.black)
                    .padding(.bottom, 80)
                
                Button {
                    coordinator.pop()
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
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let editExerciseUsecase: EditExerciseUsecase = .init(exerciseRepository: ExerciseRepositoryTest())
    let exercise: ExerciseV = .init(id: "23487", name: "Squat", parts: [.leg], favorite: true)
    let viewModel: ExerciseEditViewModel = .init(exercise: exercise, editExerciseUsecase: editExerciseUsecase)
    return ExerciseEditView(viewModel: viewModel)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
