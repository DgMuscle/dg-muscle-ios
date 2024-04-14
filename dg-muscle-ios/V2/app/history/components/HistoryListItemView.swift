//
//  HistoryListItemView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct HistoryListItemView: View {
    
    @State var history: ExerciseHistorySection.History
    let exerciseRepository: ExerciseRepositoryV2
    let healthRepository: HealthRepository
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                    Text(getDay(history: history)).italic()
                }
                .font(.title3)
                .padding(.leading, 2)
                
                HStack {
                    Text("Exercise parts:")
                    Text(getExerciseParts(allExercises: exerciseRepository.exercises, records: history.exercise.records))
                        .italic()
                        .fontWeight(.heavy)
                }
                
                if let metadata = history.metadata {
                    Text("duration: \(timeStringFor(seconds: Int(metadata.duration)))")
                        .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                        .font(.caption2)
                    
                    if let kcalPerHourKg = metadata.kcalPerHourKg, let bodyMass = healthRepository.recentBodyMass {
                        if bodyMass.unit == .kg {
                            HStack {
                                Text("consume \(Int(getKcal(duration: metadata.duration, weight: bodyMass.value, kcalPerHourKg: kcalPerHourKg))) kcal")
                                Text("(\(Int(kcalPerHourKg)))")
                            }
                            .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                            .font(.caption2)
                        }
                    }
                }
            }
            Spacer()
            volume
        }
        .foregroundStyle(Color(uiColor: .label))
    }
    
    var volume: some View {
        VStack(alignment: .center) {
            Text("Volume").font(.footnote)
            Text("\(Int(history.exercise.volume))").font(.callout).fontWeight(.black)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(uiColor: .secondarySystemBackground))
        }
    }
    
    private func getDay(history: ExerciseHistorySection.History) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        guard let date = dateformatter.date(from: history.exercise.date) else { return "" }
        
        dateformatter.dateFormat = "d"
        return dateformatter.string(from: date)
    }
    
    private func getExerciseParts(allExercises: [Exercise], records: [Record]) -> String {
        
        var recordsExerciseIds = Set<String>()
        // O(records)
        for record in records {
            recordsExerciseIds.insert(record.exerciseId)
        }
        
        var partsHashMap: [String: [Exercise.Part]] = [:]
        
        for exercise in allExercises {
            partsHashMap[exercise.id] = exercise.parts
        }
        
        var partset = Set<Exercise.Part>()
        
        for id in recordsExerciseIds {
            if let parts = partsHashMap[id] {
                parts.forEach({ partset.insert($0) })
            }
        }
        return partset.map({ $0.rawValue }).sorted().joined(separator: ", ")
    }
    
    private func timeStringFor(seconds: Int) -> String {
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
    
    private func getKcal(duration: TimeInterval, weight: Double, kcalPerHourKg: Double) -> Double {
        let hours = duration / 3600
        let kg = weight
        let kcal = kcalPerHourKg * hours * kg
        return kcal
    }
}

#Preview {
    let sets: [ExerciseSet] = [
        .init(unit: .kg, reps: 10, weight: 75, id: "1"),
        .init(unit: .kg, reps: 10, weight: 75, id: "2"),
        .init(unit: .kg, reps: 10, weight: 75, id: "3"),
        .init(unit: .kg, reps: 10, weight: 75, id: "4"),
        .init(unit: .kg, reps: 10, weight: 75, id: "5"),
    ]
    
    let records: [Record] = [
        .init(id: "1", exerciseId: "squat", sets: sets),
        .init(id: "2", exerciseId: "squat", sets: sets),
        .init(id: "3", exerciseId: "squat", sets: sets),
        .init(id: "4", exerciseId: "squat", sets: sets),
        .init(id: "5", exerciseId: "bench press", sets: sets),
    ]
    
    let exerciseHistory = ExerciseHistory(id: "1", date: "20240404", memo: "memo", records: records, createdAt: nil)
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let startDate = dateFormatter.date(from: "2024-04-04 20:00:00")!
    let endDate = dateFormatter.date(from: "2024-04-04 20:20:00")
    
    let metadata = WorkoutMetaData(duration: 2500, kcalPerHourKg: 82, startDate: startDate, endDate: endDate)
    
    let history = ExerciseHistorySection.History(exercise: exerciseHistory, metadata: metadata)
    
    return HistoryListItemView(history: history, exerciseRepository: ExerciseRepositoryV2Test(), healthRepository: HealthRepositoryTest()).preferredColorScheme(.dark)
}
