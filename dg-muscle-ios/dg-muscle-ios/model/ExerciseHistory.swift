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

extension Array where Element == ExerciseHistory {
    func volumeByPart() -> [String: Double] {
        var dictionary: [String: Double] = [:]
        
        self.forEach { history in
            history.records.forEach { record in
                if let exercise = store.exercise.exercises.first(where: { $0.id == record.exerciseId }) {
                    exercise.parts.forEach { part in
                        if dictionary[part.rawValue] != nil {
                            dictionary[part.rawValue]? += record.volume
                        } else {
                            dictionary[part.rawValue] = record.volume
                        }
                    }
                }
            }
        }
        return dictionary
    }
}
