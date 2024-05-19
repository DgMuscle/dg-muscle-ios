//
//  ExerciseManagerView.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import Domain
import MockData

public struct ExerciseManagerView: View {
    
    @StateObject var viewModel: ExerciseManagerViewModel
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
            Text("Not Empty")
        }
    }
}

#Preview {
    return ExerciseManagerView(
        exerciseRepository: ExerciseRepositoryMock(),
        addExerciseAction: nil
    )
    .preferredColorScheme(.dark)
}
