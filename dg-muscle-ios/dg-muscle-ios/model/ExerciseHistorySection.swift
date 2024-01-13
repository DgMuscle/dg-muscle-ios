//
//  ExerciseHistorySection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

import Foundation

struct ExerciseHistorySection: Identifiable {
    let id = UUID().uuidString
    let histories: [History]
    
    private var date: Date {
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
    struct History: Identifiable {
        let id = UUID().uuidString
        let exercise: ExerciseHistory
        let metadata: WorkoutMetaData?
    }
}
