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
    func tapProfile()
    func tapGrass(histories: [ExerciseHistory], volumeByPart: [String: Double])
}

struct ExerciseDiaryView: View {
    
    let dependency: ExerciseDiaryDependency
    private let profileImageSize: CGFloat = 30
    
    @State var addFloatingButtonVisible = false
    @StateObject var historyStore = store.history
    @StateObject var userStore = store.user
    @StateObject var healthStore = store.health
    
    var body: some View {
        ZStack {
            ScrollView {
                
                Spacer(minLength: 50)
                
                if historyStore.historyGrassData.isEmpty == false {
                    grass
                        .scrollTransition { effect, phase in
                            effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                        }
                }
                
                VStack {
                    profileButton
                    Spacer(minLength: 20)
                    addButton
                }
                .padding(.vertical)
                .scrollTransition { effect, phase in
                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                }

                ForEach(historyStore.historySections) { section in
                    
                    Section {
                        ForEach(section.histories) { history in
                            historyItem(history: history)
                                .scrollTransition { effect, phase in
                                    effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                                }
                                .onAppear {
                                    if history.exercise == historyStore.histories.last {
                                        dependency.scrollBottom()
                                    }
                                }
                        }
                    } header: {
                        HStack {
                            Text(section.header)
                            Spacer()
                        }
                        .padding(.bottom)
                        .scrollTransition { effect, phase in
                            effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                        }
                    } footer: {
                        VStack {
                            let volumeByPart = section.histories.map ({ $0.exercise }).volumeByPart()
                            if volumeByPart.isEmpty == false {
                                let datas: [PieChartView.Data] = volumeByPart.map({ .init(name: $0.key, value: $0.value) })
                                PieChartView(datas: datas)
                            }
                            HStack {
                                Text("total volume: \(Int(section.volume))")
                                    .italic()
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        .scrollTransition { effect, phase in
                            effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                        }
                    }
                }
            }
            .padding()
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
        .ignoresSafeArea()
    }
    
    var grass: some View {
        Section {
            GrassView(datas: historyStore.historyGrassData)
                .padding(.vertical, 8)
                .onTapGesture {
                    dependency.tapGrass(histories: historyStore.histories, volumeByPart: historyStore.histories.volumeByPart())
                }
                .listRowBackground(Color.clear)
        }
    }
    
    var profileButton: some View {
        HStack {
            Button {
                dependency.tapProfile()
            } label: {
                HStack {
                    KFImage(userStore.photoURL)
                        .placeholder {
                            Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                        }
                        .resizable()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .scaledToFit()
                        .clipShape(.circle)
                    
                    if let displayName = userStore.displayName {
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
            
            Spacer()
        }
    }
    
    var addButton: some View {
        HStack {
            Button("add history", systemImage: "plus.app") {
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
            Spacer()
        }
    }
    
    func historyItem(history: ExerciseHistorySection.History) -> some View {
        Button {
            dependency.tapHistory(history: history.exercise)
        } label: {
            VStack {
                if history.exercise.memo?.isEmpty == false {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .padding(.leading, 20)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        Spacer()
                    }
                    .padding(.bottom, 2)
                }
                
                HStack {
                    Text(onlyDay(from: history.exercise.date))
                        .font(.caption2)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    
                    Text(getParts(from: history.exercise.records))
                        .italic()
                        .font(.footnote)
                    
                    Spacer()
                    Text("\(Int(history.exercise.volume))")
                        .font(.footnote)
                }
                
                if let metaData = history.metadata {
                    metadata(metaData: metaData)
                        .padding(.bottom, 10)
                } else {
                    Spacer(minLength: 20)
                }
            }
            .foregroundStyle(Color(uiColor: .label))
        }
    }
    
    func metadata(metaData: WorkoutMetaData) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("duration: \(timeStringFor(seconds: Int(metaData.duration)))")
                        .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                        .font(.caption2)
                }
                
                if let kcalPerHourKg = metaData.kcalPerHourKg, let bodyMass = healthStore.recentBodyMass {
                    if bodyMass.unit == .kg {
                        HStack {
                            Text("consume \(Int(getKcal(duration: metaData.duration, weight: bodyMass.value, kcalPerHourKg: kcalPerHourKg))) kcal")
                            Text("(\(Int(kcalPerHourKg)))")
                        }
                        .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                        .font(.caption2)
                    }
                }
            }
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground))
            }
            Spacer()
        }
        .padding(.top, 6)
        .padding(.leading, 18)
    }
    
    func onlyDay(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
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
    
    func timeStringFor(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        var timeString = ""
        if hours > 0 {
            timeString += "\(hours)h "
        }
        if minutes > 0 {
            timeString += "\(minutes)m "
        }
        if remainingSeconds > 0 || (hours == 0 && minutes == 0) {
            timeString += "\(remainingSeconds)s"
        }
        return timeString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getKcal(duration: TimeInterval, weight: Double, kcalPerHourKg: Double) -> Double {
        let hours = duration / 3600
        let kg = weight
        let kcal = kcalPerHourKg * hours * kg
        return kcal
    }
}

#Preview {
    
    struct DP: ExerciseDiaryDependency {
        func tapAddHistory() { }
        func tapHistory(history: ExerciseHistory) { }
        func scrollBottom() { }
        func tapProfile() { }
        func tapGrass(histories: [ExerciseHistory], volumeByPart: [String: Double]) { }
    }
    
    store.history.updateHistories()
    store.exercise.updateExercises()
    store.health
    
    return ExerciseDiaryView(dependency: DP(), addFloatingButtonVisible: false).preferredColorScheme(.dark)
}
