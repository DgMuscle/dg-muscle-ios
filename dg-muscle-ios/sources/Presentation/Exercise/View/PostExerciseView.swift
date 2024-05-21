//
//  PostExerciseView.swift
//  Exercise
//
//  Created by Donggyu Shin on 5/21/24.
//

import SwiftUI
import Domain

public struct PostExerciseView: View {
    @StateObject var viewModel: PostExerciseViewModel
    
    public init(
        exercise: Exercise?,
        exerciseRepository: ExerciseRepository
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                exercise: exercise,
                exerciseRepository: exerciseRepository
            )
        )
    }
    
    public var body: some View {
        VStack {
            Text("Post Exercise View")
        }
    }
}
