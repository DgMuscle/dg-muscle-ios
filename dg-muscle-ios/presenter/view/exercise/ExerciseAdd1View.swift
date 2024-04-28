//
//  ExerciseAdd1View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct ExerciseAdd1View: View {
    
    @StateObject var viewModel: ExerciseAdd1ViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if viewModel.canProceed {
                    Button {
                        coordinator.exercise.add2(exerciseName: viewModel.name, exerciseParts: viewModel.parts)
                    } label: {
                        HStack {
                            Text("Next")
                            Image(systemName: "arrowshape.right")
                        }
                        .foregroundStyle(Color(uiColor: .label))
                        .fontWeight(.black)
                        .padding(.bottom, 40)
                    }
                }
                
                if viewModel.isVisiblePartsForm {
                    Text("What are the target parts of this exercise?").font(.headline)
                    ExercisePartsSectionView(viewModel: .init(parts: $viewModel.parts))
                        .padding(.bottom, 40)
                }
                
                Text("What's the name of the exercise?").font(.headline)
                TextField("Squat", text: $viewModel.name)
                    .fontWeight(.black)
                    .focused($isFocused)
                    .onAppear {
                        isFocused.toggle()
                    }
                Divider()
                
                Spacer()
            }
            .padding()
            .animation(.default, value: viewModel.isVisiblePartsForm)
            .animation(.default, value: viewModel.canProceed)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let viewModel: ExerciseAdd1ViewModel = .init()
    return ExerciseAdd1View(viewModel: viewModel)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    .environmentObject(CoordinatorV2(path: .constant(.init())))
}
