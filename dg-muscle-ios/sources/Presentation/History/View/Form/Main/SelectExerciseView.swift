//
//  SelectExerciseView.swift
//  History
//
//  Created by 신동규 on 5/24/24.
//

import SwiftUI
import Domain
import MockData
import Common

public struct SelectExerciseView: View {
    
    @StateObject var viewModel: SelectExerciseViewModel
    let tapExercise: ((HistoryExercise) -> ())?
    let add: (() -> ())?
    let close: (() -> ())?
    let run: (() -> ())?
    
    public init(
        exerciseRepository: ExerciseRepository,
        userRepository: UserRepository,
        historyRepository: HistoryRepository,
        tapExercise: ((HistoryExercise) -> ())?,
        add: (() -> ())?,
        close: (() -> ())?,
        run: (() -> ())?
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                exerciseRepository: exerciseRepository,
                userRepository: userRepository, 
                historyRepository: historyRepository
            )
        )
        self.tapExercise = tapExercise
        self.add = add
        self.close = close
        self.run = run
    }
    
    public var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Button(viewModel.onlyShowsFavoriteExercises ? "Show all" : "Show only favorites") {
                    viewModel.updateOnlyShowsFavoriteExercises(value: !viewModel.onlyShowsFavoriteExercises)
                }
                
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
                                    
                                    Spacer()
                                    
                                    Common.CircularProgressView(
                                        progress: exercise.popularity,
                                        lineWidth: 4,
                                        color: viewModel.color
                                    )
                                    .frame(width: 18)
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
        userRepository: UserRepositoryMock(),
        historyRepository: HistoryRepositoryMock(),
        tapExercise: nil,
        add: nil,
        close: nil, 
        run: nil
    )
    .preferredColorScheme(.dark)
}
