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
    func tapPreviusRecordButton(record: Record, dateString: String)
}

struct RecordFormView: View {
    
    @StateObject var exerciseStore = store.exercise
    @StateObject var notificationCenter = RecordFormNotificationCenter.shared
    @State var selectedExercise: Exercise?
    @State var sets: [ExerciseSet]
    let dependency: RecordFormDependency
    let dateString: String
    
    var currentVolume: Double {
        sets.reduce(0, { $0 + $1.volume })
    }
    
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
                .padding(.horizontal)
                
                if currentVolume > 0 {
                    HStack {
                        Text("current exercise volume: \(Int(currentVolume))")
                            .italic()
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
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
                .scrollIndicators(.hidden)
                
                if let record = recentRecord() {
                    HStack(spacing: 0) {
                        if currentVolume > record.volume {
                            Text("you exercised")
                            Text(" \(Int(currentVolume - record.volume))").foregroundStyle(Color.green)
                            Text(" volumes more than before")
                        } else {
                            Text("you exercised")
                            Text(" \(Int(record.volume - currentVolume))").foregroundStyle(Color.red)
                            Text(" volumes less than before")
                        }
                        Spacer()
                    }
                    .italic()
                    .padding(.horizontal)
                    
                    Button {
                        dependency.tapPreviusRecordButton(record: record, dateString: dateString)
                    } label: {
                        HStack {
                            Text("Go to see previus record")
                                .italic()
                            Image(systemName: "arrowshape.turn.up.right")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .foregroundStyle(Color.gray)
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
    
    // Get the recent previous record which has same exercise
    func recentRecord() -> Record? {
        var histories = store.history.histories
        histories = histories.filter({ $0.date < self.dateString })
        guard let recentHistory = histories.first(where: { history in
            history.records.contains(where: { $0.exerciseId == selectedExercise?.id ?? "" })
        }) else { return nil }
        return recentHistory.records.first(where: { $0.exerciseId == selectedExercise?.id ?? "" })
    }
}
