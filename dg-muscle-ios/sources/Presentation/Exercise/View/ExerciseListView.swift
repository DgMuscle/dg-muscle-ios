//
//  ExerciseListView.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import Domain
import MockData

public struct ExerciseListView: View {
    
    @StateObject var viewModel: ExerciseListViewModel
    private let addExerciseAction: ((Exercise?) -> ())?
    
    public init(
        exerciseRepository: any ExerciseRepository,
        addExerciseAction: ((Exercise?) -> ())?
    ) {
        _viewModel = .init(wrappedValue:
                .init(
                    exerciseRepository: exerciseRepository
                )
        )
        
        self.addExerciseAction = addExerciseAction
    }
    
    public var body: some View {
        if viewModel.exerciseSections.isEmpty {
            ExerciseEmptyView {
                addExerciseAction?(nil)
            }
            .padding(.horizontal)
        } else {
            List {
                ForEach(viewModel.exerciseSections, id: \.self) { section in
                    ExerciseSectionView(exerciseSection: section) { exercise in
                        addExerciseAction?(exercise)
                    }
                }
                
                Button {
                    addExerciseAction?(nil)
                } label: {
                    HStack {
                        Spacer()
                        Text("ADD")
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    return ExerciseListView(
        exerciseRepository: ExerciseRepositoryMock(),
        addExerciseAction: nil
    )
    .preferredColorScheme(.dark)
}
