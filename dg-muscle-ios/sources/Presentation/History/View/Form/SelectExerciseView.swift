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
    let add: (() -> ())?
    let close: (() -> ())?
    
    init(
        exerciseRepository: ExerciseRepository,
        tapExercise: ((Exercise) -> ())?,
        add: (() -> ())?,
        close: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(exerciseRepository: exerciseRepository)
        )
        self.tapExercise = tapExercise
        self.add = add
        self.close = close
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button("Manage") {
                    add?()
                }
                
                Button("Close") {
                    close?()
                }
            }
            .padding(.horizontal)
            
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
                                            .hidden()
                                    }
                                    
                                    Text(exercise.name)
                                }
                                .foregroundStyle(Color(uiColor: .label))
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    return SelectExerciseView(
        exerciseRepository: ExerciseRepositoryMock(),
        tapExercise: nil,
        add: nil,
        close: nil
    )
    .preferredColorScheme(.dark)
}
