//
//  RecordFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import SwiftUI
import Combine

final class RecordFormNotificationCenter {
    static let shared = RecordFormNotificationCenter()
    
    @Published var set: ExerciseSet?
    
    private init() { }
}

protocol RecordFormDependency {
    func addExercise()
    func addSet()
    func save(record: Record)
}

struct RecordFormView: View {
    
    @StateObject var exerciseStore = store.exercise
    @State var selectedExercise: Exercise?
    @State var sets: [ExerciseSet]
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
                            .foregroundStyle(selectedExercise == exercise ? .white : Color(uiColor: .label))
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
                    ForEach($sets) { $set in
                        HStack {
                            
                            Text("\(set.weight)\(set.unit.rawValue) x \(set.reps)")
                            Spacer()
                            
                            Image(systemName: "plus")
                                .padding(6)
                                .onTapGesture {
                                    withAnimation {
                                        set.reps = set.reps + 1
                                    }
                                }
                                .foregroundStyle(.tint)
                            
                            Image(systemName: "minus")
                                .padding(6)
                                .onTapGesture {
                                    withAnimation {
                                        if set.reps > 1 {
                                            set.reps = set.reps - 1
                                        }
                                    }
                                }
                                .foregroundStyle(.tint)
                        }
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            indexSet.forEach({ sets.remove(at: $0) })
                        }
                    }
                    
                    if let lastSet = sets.last {
                        Button {
                            withAnimation {
                                sets.append(lastSet)
                            }
                        } label: {
                            Text("\(lastSet.weight)\(lastSet.unit.rawValue) x \(lastSet.reps)")
                                .italic()
                        }
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
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
                        Text("Save")
                            .foregroundStyle(.white)
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
        .onChange(of: RecordFormNotificationCenter.shared.set) { _, value in
            if let value {
                withAnimation {
                    sets.append(value)
                }
            }
        }
    }
}
