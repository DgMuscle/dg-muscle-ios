//
//  GrassView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/23/23.
//

import SwiftUI

struct GrassView: View {
    var body: some View {
        Text("GrassView")
    }
    
    static private func generateDates(startingFrom startDate: Date, numberOfDays: Int) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate
        let calendar = Calendar.current
        
        // Generate dates for the specified number of days
        for _ in 1...numberOfDays {
            dates.append(currentDate)
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                // If adding a day results in nil, break the loop
                break
            }
        }
        
        return dates
    }
    
    static private func subtractDays(from date: Date, numberOfDays: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = -numberOfDays
        
        if let subtractedDate = Calendar.current.date(byAdding: dateComponents, to: date) {
            return subtractedDate
        } else {
            return nil
        }
    }
}
