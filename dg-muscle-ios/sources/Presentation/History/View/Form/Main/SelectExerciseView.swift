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
    let run: (() -> ())?
    
    init(
        exerciseRepository: ExerciseRepository,
        tapExercise: ((Exercise) -> ())?,
        add: (() -> ())?,
        close: (() -> ())?,
        run: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(exerciseRepository: exerciseRepository)
        )
        self.tapExercise = tapExercise
        self.add = add
        self.close = close
        self.run = run
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
                Button("Run", systemImage: "figure.run") {
                    run?()
                }
                .foregroundStyle(.white)
                .listRowBackground(
                    LinearGradient(
                        colors: [
                            .blue.opacity(0.3),
                            .blue.opacity(0.8)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                
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
        close: nil, 
        run: nil
    )
    .preferredColorScheme(.dark)
}
