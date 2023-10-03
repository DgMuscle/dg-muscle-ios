//
//  ExerciseListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/3/23.
//

import SwiftUI
import Combine

final class ExerciseListViewNotificationCenter: ObservableObject {
    static let shared = ExerciseListViewNotificationCenter()
    private init() { }
    
    @Published var exercises: [Exercise] = []
}

protocol ExerciseListViewDependency {
    func tapAdd()
    func tapSave(exercises: [Exercise])
}

struct ExerciseListView: View {
    let dependency: ExerciseListViewDependency
    @StateObject var notificationCenter = ExerciseListViewNotificationCenter.shared
    @State var exercises: [Exercise]
    
    var body: some View {
        Form {
            Section("exercises") {
                ForEach(exercises) { exercise in
                    Text(exercise.name)
                }
                .onDelete { indexSet in
                    exercises.remove(atOffsets: indexSet)
                }
                .onMove { from, to in
                    exercises.move(fromOffsets: from, toOffset: to)
                }
                Button("Add", systemImage: "plus.app") {
                    dependency.tapAdd()
                }
            }
            Button("Save") {
                let exercises = exercises.enumerated().map({ index, exercise in
                    var exercise = exercise
                    exercise.order = index
                    return exercise
                })
                dependency.tapSave(exercises: exercises)
            }
        }
        .onChange(of: notificationCenter.exercises) { _, newValue in
            withAnimation {
                self.exercises = newValue
            }
        }
    }
}
