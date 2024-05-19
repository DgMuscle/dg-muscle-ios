//
//  ExerciseSectionView.swift
//  Exercise
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import MockData

struct ExerciseSectionView: View {
    
    let exerciseSection: ExerciseSection
    let tapExercise: ((Exercise) -> ())?
    let deleteExercise: ((Exercise.Part, IndexSet) -> ())?
    
    init(
        exerciseSection: ExerciseSection,
        tapExercise: ((Exercise) -> ())?,
        deleteExercise: ((Exercise.Part, IndexSet) -> ())?
    ) {
        self.exerciseSection = exerciseSection
        self.tapExercise = tapExercise
        self.deleteExercise = deleteExercise
    }
    
    var body: some View {
        Section(exerciseSection.part.rawValue.capitalized) {
            ForEach(exerciseSection.exercises, id: \.self) { exercise in
                Button {
                    tapExercise?(exercise)
                } label: {
                    HStack {
                        Text(exercise.name)
                            .foregroundStyle(Color(uiColor: .label))
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                .listRowBackground(exercise.favorite ? Color.yellow.opacity(0.2) : nil)
            }
            .onDelete(perform: delete)
        }
    }
    
    private func delete(indexSet: IndexSet) {
        deleteExercise?(exerciseSection.part, indexSet)
    }
}

#Preview {
    
    let section: ExerciseSection = .init(
        part: .leg, 
        exercises: [
            .init(domain: EXERCISE_DEAD),
            .init(domain: EXERCISE_SQUAT)
        ]
    )
    return List {
        ExerciseSectionView(
            exerciseSection: section,
            tapExercise: nil,
            deleteExercise: nil
        )
    }
    .preferredColorScheme(.dark)
}
