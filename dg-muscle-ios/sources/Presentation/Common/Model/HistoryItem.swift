//
//  HistoryItem.swift
//  Presentation
//
//  Created by 신동규 on 6/14/24.
//

import Foundation
import SwiftUI
import Domain

public struct HistoryItem: Hashable {
    public let id: String
    public let date: Date
    public let parts: [String]
    public let volume: Double
    public let color: Color
    public let time: Double?
    public let kcal: Double?
    
    public init(id: String, date: Date, parts: [String], volume: Double, color: Color, time: Double?, kcal: Double?) {
        self.id = id
        self.date = date
        self.parts = parts
        self.volume = volume
        self.color = color
        self.time = time
        self.kcal = kcal
    }
    
    public init(history: Domain.History, exercises: [Domain.Exercise], color: Color) {
        self = Self.convert(history: history, exercises: exercises, color: color)
    }
    
    static private func convert(history: Domain.History, exercises: [Domain.Exercise], color: Color) -> HistoryItem {
        
        var parts = Set<Domain.Exercise.Part>()
        let exerciseIdList: [String] = history.records.map({ $0.exerciseId })
        
        
        for id in exerciseIdList {
            if let exercise = exercises.first(where: { $0.id == id }) {
                exercise.parts.forEach({ parts.insert($0) })
            }
        }
        
        return .init(id: history.id,
                     date: history.date,
                     parts: parts.map({ convert(part: $0) }).sorted(),
                     volume: history.volume,
                     color: color,
                     time: nil,
                     kcal: nil)
    }
    
    static private func convert(part: Domain.Exercise.Part) -> String {
        switch part {
        case .arm:
            return "Arm"
        case .back:
            return "Back"
        case .chest:
            return "Chest"
        case .core:
            return "Core"
        case .leg:
            return "Leg"
        case .shoulder:
            return "Shoulder"
        }
    }
}

