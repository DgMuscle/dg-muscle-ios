//
//  ExerciseDiaryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import SwiftUI

protocol ExerciseDiaryDependency {
    func tapAddHistory()
    func tapHistory(history: ExerciseHistory)
    func scrollBottom()
    func delete(data: ExerciseHistory)
    func tapChart()
}

struct ExerciseDiaryView: View {
    
    let dependency: ExerciseDiaryDependency
    
    @StateObject var historyStore = store.history
    @State var addFloatingButtonVisible = false
    
    var body: some View {
        ZStack {
            List {
                Button("Add record", systemImage: "plus.app") {
                    dependency.tapAddHistory()
                }
                .onAppear {
                    withAnimation {
                        addFloatingButtonVisible = false
                    }
                }
                .onDisappear {
                    withAnimation {
                        addFloatingButtonVisible = true
                    }
                }
                
                ForEach(historyStore.historySections) { section in
                    Section {
                        ForEach(section.histories) { history in
                            Button {
                                dependency.tapHistory(history: history)
                            } label: {
                                VStack {
                                    HStack {
                                        Text(history.date).frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(Int(history.volume))").frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    Text(getParts(from: history.records)).frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                                        .font(.caption2)
                                }
                                .foregroundStyle(Color(uiColor: .label))
                            }
                            .onAppear {
                                if history == store.history.histories.last {
                                    dependency.scrollBottom()
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach({
                                dependency.delete(data: section.histories[$0])
                            })
                        }
                    } header: {
                        Text(section.header)
                    } footer: {
                        VStack {
                            let volumeByPart = section.volumeByPart
                            if volumeByPart.isEmpty == false {
                                let datas: [PieChartView.Data] = volumeByPart.map({ .init(name: $0.key, value: $0.value) })
                                PieChartView(datas: datas)
                                    .onTapGesture(perform: dependency.tapChart)
                            }
                            HStack {
                                Text("total volume: \(Int(section.volume))").italic()
                                Spacer()
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            VStack {
                Spacer()
                if addFloatingButtonVisible {
                    Button("Add", systemImage: "plus.app") {
                        dependency.tapAddHistory()
                    }
                    .padding()
                    .background {
                        Capsule().fill(Color(uiColor: .secondarySystemBackground)).opacity(0.5)
                    }
                }
            }
        }
    }
    
    func getParts(from records: [Record]) -> String {
        let exercisesIds = records.compactMap { $0.exerciseId }
        let exercises = store.exercise.exercises.filter({ exercise in
            exercisesIds.contains(exercise.id)
        })
        let allParts = exercises.map({ $0.parts }).flatMap({ $0 })
        let parts = Array(Set(allParts)).sorted()
        
        if parts.count == Exercise.Part.allCases.count {
            return "all"
        } else {
            return parts.map({ $0.rawValue }).joined(separator: ", ")
        }
    }
}
