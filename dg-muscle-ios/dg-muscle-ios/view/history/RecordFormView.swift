//
//  RecordFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import SwiftUI

protocol RecordFormDependency {
    func addExercise()
    func addSet()
    func save(record: Record)
}

struct RecordFormView: View {
    
    @StateObject var exerciseStore = store.exercise
    @State var selectedExercise: Exercise?
    @State var sets: [ExerciseSet] = []
    let dependency: RecordFormDependency
    
    var body: some View {
        VStack {
            if selectedExercise == nil {
                Text("Select exercise")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .padding()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    Spacer(minLength: 12)
                    ForEach(exerciseStore.exercises) { exercise in
                        Text(exercise.name)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 8).fill(
                                    selectedExercise == exercise ? Color(uiColor: .systemBlue) : Color(uiColor: .secondarySystemBackground)
                                )
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedExercise = exercise
                                }
                            }
                    }
                    Button("add", systemImage: "plus.circle") {
                        dependency.addExercise()
                    }
                    Spacer(minLength: 12)
                }
            }
            .scrollIndicators(.hidden)
            
            if let selectedExercise {
                
                HStack {
                    Text("Record sets").font(.largeTitle)
                    Text("(\(selectedExercise.name))").italic()
                    Spacer()
                }
                .padding()
                
                List {
                    ForEach(sets) { set in
                        Text("\(set.weight)\(set.unit.rawValue) x \(set.reps)")
                    }
                    Button("Add", systemImage: "plus.app") {
                        dependency.addSet()
                    }
                }
                
                if sets.isEmpty == false {
                    Button {
                        let record = Record(exerciseId: selectedExercise.id, sets: sets)
                        dependency.save(record: record)
                    } label: {
                        Text("Save").foregroundStyle(Color(uiColor: .label))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10).fill(.blue)
                            }
                            .padding()
                    }
                }
            }
            Spacer()
        }
    }
}
