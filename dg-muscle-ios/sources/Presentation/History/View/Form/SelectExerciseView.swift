//
//  SelectExerciseView.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import SwiftUI
import Domain
import MockData

struct SelectExerciseView: View {
    
    @StateObject var viewModel: SelectExerciseViewModel
    let tapExercise: ((Exercise) -> ())?
    
    init(
        exerciseRepository: ExerciseRepository,
        tapExercise: ((Exercise) -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(exerciseRepository: exerciseRepository)
        )
        self.tapExercise = tapExercise
    }
    
    var body: some View {
        List {
            ForEach(viewModel.exericeSections, id: \.self) { section in
                Section(section.part.rawValue) {
                    ForEach(section.exercises, id: \.self) { exercise in
                        Button {
                            tapExercise?(exercise)
                        } label: {
                            HStack {
                                if exercise.favorite {
                                    Image(systemName: "star")
                                        .foregroundStyle(.yellow)
                                } else {
                                    Image(systemName: "star")
                                }
                                
                                Text(exercise.name)
                            }
                            .foregroundStyle(Color(uiColor: .label))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    return SelectExerciseView(
        exerciseRepository: ExerciseRepositoryMock(),
        tapExercise: nil
    )
    .preferredColorScheme(.dark)
}
