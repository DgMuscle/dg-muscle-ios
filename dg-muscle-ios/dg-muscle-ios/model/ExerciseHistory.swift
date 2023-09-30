//
//  ExerciseHistory.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseHistory: Codable, Identifiable, Equatable {
    static func == (lhs: ExerciseHistory, rhs: ExerciseHistory) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let date: String
    let memo: String?
    let records: [Record]
    let createdAt: CreatedAt
    
    var volume: Int {
        let allSets: [ExerciseSet] = records.map({ $0.sets }).flatMap({ $0 })
        return allSets.reduce(0, { $0 + ($1.reps * $1.weight) })
    }
    
    var dateValue: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: date)
    }
}
