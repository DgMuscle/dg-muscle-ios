//
//  ExerciseDiaryView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import SwiftUI
import Kingfisher

protocol ExerciseDiaryDependency {
    func tapAddHistory()
    func tapHistory(history: ExerciseHistory)
    func scrollBottom()
    func delete(data: ExerciseHistory)
    func tapChart(histories: [ExerciseHistory], volumeByPart: [String: Double])
    func tapProfile()
    func tapGrass(histories: [ExerciseHistory], volumeByPart: [String: Double])
}

struct ExerciseDiaryView: View {
    
    let dependency: ExerciseDiaryDependency
    private let profileImageSize: CGFloat = 30
    
    @State var addFloatingButtonVisible = false
    @StateObject var historyStore = store.history
    
    var body: some View {
        ZStack {
            List {
                Button {
                    dependency.tapProfile()
                } label: {
                    HStack {
                        KFImage(store.user.photoURL)
                            .placeholder {
                                Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                            }
                            .resizable()
                            .frame(width: profileImageSize, height: profileImageSize)
                            .scaledToFit()
                            .clipShape(.circle)
                        
                        if let displayName = store.user.displayName {
                            Text(displayName)
                                .foregroundStyle(Color(uiColor: .label))
                                .font(.caption)
                                .italic()
                        } else {
                            Text("fill your profile")
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .font(.caption)
                                .italic()
                        }
                    }
                }

                if historyStore.historyGrassData.isEmpty == false {
                    GrassView(datas: historyStore.historyGrassData, count: 17)
                        .onTapGesture {
                            dependency.tapGrass(histories: historyStore.histories, volumeByPart: historyStore.histories.volumeByPart())
                        }
                }
                
                Section {
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
                                if history == historyStore.histories.last {
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
                            let volumeByPart = section.histories.volumeByPart()
                            if volumeByPart.isEmpty == false {
                                let datas: [PieChartView.Data] = volumeByPart.map({ .init(name: $0.key, value: $0.value) })
                                PieChartView(datas: datas)
                                    .onTapGesture {
                                        dependency.tapChart(histories: section.histories, volumeByPart: volumeByPart)
                                    }
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
