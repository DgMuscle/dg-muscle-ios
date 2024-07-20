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
                        Image(systemName: "star")
                            .foregroundStyle(.yellow)
                            .opacity(exercise.favorite ? 1 : 0)
                        Text(exercise.name)
                            .foregroundStyle(Color(uiColor: .label))
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
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
        exercises: EXERCISES.map({ .init(domain: $0) })
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
