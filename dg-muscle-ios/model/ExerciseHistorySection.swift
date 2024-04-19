//
//  ExerciseHistorySection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseHistorySection: Identifiable, Equatable {
    static func == (lhs: ExerciseHistorySection, rhs: ExerciseHistorySection) -> Bool {
        lhs.id == rhs.id && lhs.histories == rhs.histories
    }
    
    let id = UUID().uuidString
    var histories: [History]
    
    var date: Date {
        let dateString = histories.first?.exercise.date ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    var header: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter.string(from: date)
    }
    
    var volume: Double {
        histories.map({ $0.exercise.volume }).reduce(0.0, { $0 + $1 })
    }
}

extension ExerciseHistorySection {
    struct History: Identifiable, Equatable {
        static func == (lhs: ExerciseHistorySection.History, rhs: ExerciseHistorySection.History) -> Bool {
            lhs.id == rhs.id && lhs.exercise == rhs.exercise && lhs.metadata == rhs.metadata
        }
        
        let id = UUID().uuidString
        let exercise: ExerciseHistory
        let metadata: WorkoutMetaData?
    }
}
