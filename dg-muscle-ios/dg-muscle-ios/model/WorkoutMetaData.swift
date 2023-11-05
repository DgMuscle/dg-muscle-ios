//
//  WorkoutMetaData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 11/5/23.
//

import Foundation

struct WorkoutMetaData {
    let duration: TimeInterval
    let kcalPerHourKg: Double?
    let startDate: Date
    let endDate: Date?
    
    var startDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: startDate)
    }
}
