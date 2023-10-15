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
    
    var footer: Double {
        histories.map({ $0.volume }).reduce(0.0, { $0 + $1 })
    }
    
    var volumeByPart: [String: Double] {
        
        var volumeByPart: [String: Double] = [:]
        
        histories.forEach { history in
            history.records.forEach { record in
                if let exercise = store.exercise.exercises.first(where: { $0.id == record.exerciseId }) {
                    exercise.parts.forEach { part in
                        if volumeByPart[part.rawValue] != nil {
                            volumeByPart[part.rawValue]? += record.volume
                        } else {
                            volumeByPart[part.rawValue] = record.volume
                        }
                    }
                }
            }
        }
        
        return volumeByPart
    }
}
