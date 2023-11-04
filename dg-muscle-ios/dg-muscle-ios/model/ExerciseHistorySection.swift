//
//  ExerciseHistorySection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//
import Foundation

struct ExerciseHistorySection: Identifiable {
    let id = UUID().uuidString
    let histories: [ExerciseHistory]
    
    private var date: Date {
        let dateString = histories.first?.date ?? ""
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
        histories.map({ $0.volume }).reduce(0.0, { $0 + $1 })
    }
}
