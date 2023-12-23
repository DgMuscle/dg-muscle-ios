//
//  GrassView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/23/23.
//

import SwiftUI

struct GrassView: View {
    static private let row = 7
    static private let item = 20
    
    var body: some View {
        Text("GrassView")
    }
    
    static func getHistoryGrassData(from datasource: [GrassDatasource]) -> [GrassData] {
        
        let itemCount = row * item
        guard let startDate = subtractDays(from: Date(), numberOfDays: itemCount - 1) else { return [] }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dates = generateDates(startingFrom: startDate, numberOfDays: itemCount).compactMap({ dateFormatter.string(from: $0)})
        var datas: [GrassData] = dates.map({ date in
            guard let data = datasource.first(where: { $0.date == date }) else { return .init(date: date, value: 0) }
            return .init(date: date, value: data.volume)
        })
        
        while datas.first?.value == 0 {
            datas.removeFirst()
        }
        
        return datas
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
