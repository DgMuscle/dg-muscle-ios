//
//  PostExerciseView.swift
//  Exercise
//
//  Created by Donggyu Shin on 5/21/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct PostExerciseView: View {
    @StateObject var viewModel: PostExerciseViewModel
    
    public init(
        exercise: Exercise?,
        exerciseRepository: ExerciseRepository,
        pop: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                exercise: exercise,
                exerciseRepository: exerciseRepository,
                pop: pop
            )
        )
    }
    
    public var body: some View {
        VStack {
            if let status = viewModel.status {
                StatusView(status: status)
                    .padding(.horizontal)
            }
            
            List {
                
                if viewModel.isSaveButtonVisible {
                    Button("SAVE") {
                        viewModel.save()
                    }
                    
                    Button {
                        viewModel.exercise.favorite.toggle()
                    } label: {
                        Image(systemName: viewModel.exercise.favorite ? "star.fill" : "star")
                    }
                }
                
                if viewModel.isPartsSelectionVisible {
                    Section("Please select the parts of the exercise") {
                        PartsSelectView(selectedParts: $viewModel.exercise.parts)
                    }
                }
                
                Section("Please enter the name of the exercise") {
                    TextField("Squat", text: $viewModel.exercise.name)
                }
                
            }
            .scrollIndicators(.hidden)
        }
        .animation(.default, value: viewModel.isSaveButtonVisible)
        .animation(.default, value: viewModel.isPartsSelectionVisible)
        .animation(.default, value: viewModel.status)
    }
}

#Preview {
    return PostExerciseView(
        exercise: nil,
        exerciseRepository: ExerciseRepositoryMock(), 
        pop: nil
    )
    .preferredColorScheme(.dark)
}
