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
    @State private var canShowEmptyView: Bool = false
    private let addExerciseAction: ((Domain.Exercise?) -> ())?
    
    public init(
        exerciseRepository: any ExerciseRepository,
        historyRepository: any HistoryRepository,
        userRepository: any UserRepository,
        addExerciseAction: ((Domain.Exercise?) -> ())?
    ) {
        _viewModel = .init(wrappedValue:
                .init(
                    exerciseRepository: exerciseRepository, 
                    historyRepository: historyRepository, 
                    userRepository: userRepository
                )
        )
        
        self.addExerciseAction = addExerciseAction
    }
    
    public var body: some View {
        ZStack {
            if viewModel.exerciseSections.isEmpty && viewModel.deletedExercises.isEmpty && canShowEmptyView {
                ExerciseEmptyView {
                    addExerciseAction?(nil)
                }
                .padding(.horizontal)
            } else {
                List {
                    ForEach(viewModel.exerciseSections, id: \.self) { section in
                        ExerciseSectionView(
                            exerciseSection: section,
                            color: viewModel.color) { exercise in
                                addExerciseAction?(exercise.domain)
                            } deleteExercise: { part, indexSet in
                                viewModel.delete(part: part, indexSet: indexSet)
                            }
                    }
                    
                    if viewModel.deletedExercises.isEmpty == false {
                        Section {
                            ForEach(viewModel.deletedExercises, id: \.self) { exercise in
                                Button {
                                    viewModel.rollBack(exercise)
                                } label: {
                                    Text(exercise.name)
                                }
                                .buttonStyle(.borderless)
                            }
                        } header: {
                            Text("deleted exercises")
                        } footer: {
                            Text("tap to rollback")
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
                .scrollIndicators(.hidden)
                .toolbar {
                    EditButton()
                    Button("Add") {
                        addExerciseAction?(nil)
                    }
                }
                .animation(.default, value: viewModel.deletedExercises.isEmpty)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                canShowEmptyView.toggle()
            }
        }
    }
}

#Preview {
    let exerciseRepository = ExerciseRepositoryMock()
    let historyRepository = HistoryRepositoryMock()
    let userRepository = UserRepositoryMock()
    
    return NavigationStack {
        ExerciseListView(
            exerciseRepository: exerciseRepository,
            historyRepository: historyRepository, 
            userRepository: userRepository,
            addExerciseAction: nil
        )
        .preferredColorScheme(.dark)
    }
}
