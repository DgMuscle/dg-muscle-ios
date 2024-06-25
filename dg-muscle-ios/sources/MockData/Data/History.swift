//
//  History.swift
//  MockData
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

private func createHistory(date: String, memo: String?, records: [ExerciseRecord]) -> History {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: date)!
    
    let run: Run = .init(duration: 3600, distance: 3600)
    
    return .init(id: UUID().uuidString, date: date, memo: memo, records: records, run: run)
}

public let SETS_1: [ExerciseSet] = [
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 60)
]

public let SETS_2: [ExerciseSet] = [
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40),
    .init(id: UUID().uuidString, unit: .kg, reps: 12, weight: 40)
]

public let RECORD_1: ExerciseRecord = .init(id: UUID().uuidString, exerciseId: "squat", sets: SETS_1)
public let RECORD_2: ExerciseRecord = .init(id: UUID().uuidString, exerciseId: "bench press", sets: SETS_2)
public let RECORD_3: ExerciseRecord = .init(id: UUID().uuidString, exerciseId: "deadlift", sets: SETS_2)

public let HISTORY_1: History = createHistory(date: "20240515", memo: nil, records: [RECORD_1])
public let HISTORY_2: History = createHistory(date: "20240513", memo: nil, records: [RECORD_2])
public let HISTORY_3: History = createHistory(date: "20240415", memo: nil, records: [RECORD_3])
public let HISTORY_4: History = createHistory(date: "20240415", memo: nil, records: [RECORD_1, RECORD_2, RECORD_3])
