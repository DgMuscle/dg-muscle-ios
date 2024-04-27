//
//  ExerciseHistory.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseHistory: Codable, Identifiable, Equatable {
    static func == (lhs: ExerciseHistory, rhs: ExerciseHistory) -> Bool {
        lhs.id == rhs.id && lhs.records == rhs.records && lhs.memo == rhs.memo
    }

    let id: String
    let date: String
    var memo: String?
    var records: [Record]
    let createdAt: CreatedAt?

    var volume: Double {
        let allSets: [ExerciseSet] = records.map({ $0.sets }).flatMap({ $0 })
        return allSets.reduce(0, { $0 + $1.volume })
    }

    var dateValue: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: date)
    }
}
