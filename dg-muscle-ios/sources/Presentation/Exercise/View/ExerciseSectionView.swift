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
    
    init(
        exerciseSection: ExerciseSection,
        tapExercise: ((Exercise) -> ())?
    ) {
        var exerciseSection = exerciseSection
        exerciseSection.exercises = exerciseSection.exercises
            .sorted(by: { exercise1, _ in
                return exercise1.favorite
            })
        self.exerciseSection = exerciseSection
        self.tapExercise = tapExercise
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
        }
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
            tapExercise: nil
        )
    }
    .preferredColorScheme(.dark)
}
