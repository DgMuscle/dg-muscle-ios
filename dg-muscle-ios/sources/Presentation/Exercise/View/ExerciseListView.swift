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
        ZStack {
            if viewModel.exerciseSections.isEmpty && viewModel.deletedExercises.isEmpty && canShowEmptyView {
                ExerciseEmptyView {
                    addExerciseAction?(nil)
                }
                .padding(.horizontal)
            } else {
                List {
                    ForEach(viewModel.exerciseSections, id: \.self) { section in
                        ExerciseSectionView(exerciseSection: section) { exercise in
                            addExerciseAction?(exercise)
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
                .toolbar {
                    EditButton()
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
    return NavigationStack {
        ExerciseListView(
            exerciseRepository: ExerciseRepositoryMock(),
            addExerciseAction: nil
        )
        .preferredColorScheme(.dark)
    }
}
