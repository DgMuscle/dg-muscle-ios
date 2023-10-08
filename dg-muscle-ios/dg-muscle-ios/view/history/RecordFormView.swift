//
//  RecordFormView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 9/30/23.
//

import SwiftUI
import Combine

final class RecordFormNotificationCenter: ObservableObject {
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
    @StateObject var notificationCenter = RecordFormNotificationCenter.shared
    @State var selectedExercise: Exercise?
    @State var sets: [ExerciseSet]
    let dependency: RecordFormDependency
    
    private let buttonHeight: CGFloat = 20
    
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
                    ForEach($sets, id: \.self) { $set in
                        HStack {
                            
                            Text("\(Int(set.weight))\(set.unit.rawValue) x \(set.reps)")
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    set.reps = set.reps + 1
                                }
                            } label: {
                                Image(systemName: "plus").frame(height: buttonHeight)
                            }
                            .buttonStyle(.bordered)
                            
                            Button {
                                withAnimation {
                                    if set.reps > 1 {
                                        set.reps = set.reps - 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus").frame(height: buttonHeight)
                            }
                            .buttonStyle(.bordered)
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
                                sets.append(.init(unit: lastSet.unit, reps: lastSet.reps, weight: lastSet.weight))
                            }
                        } label: {
                            Text("\(Int(lastSet.weight))\(lastSet.unit.rawValue) x \(lastSet.reps)")
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
        .onChange(of: notificationCenter.set) { _, value in
            if let value {
                withAnimation {
                    sets.append(value)
                }
            }
        }
    }
}
