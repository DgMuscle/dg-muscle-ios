//
//  HistoryGrassView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/15/23.
//

import SwiftUI

struct GrassView: View {
    
    var datas: [GrassData]
    
    var columns: [GridItem]
    
    private let averageValue: Double
    private let highestValue: Double
    
    init(datas: [GrassData], count: Int) {
        self.datas = datas
        self.columns = Array(repeating: .init(.flexible(), spacing: 3), count: count)
        let filteredData = datas.filter({ $0.value > 0 })
        let sum = filteredData.reduce(0, { $0 + $1.value })
        averageValue = sum / Double(filteredData.count)
        self.highestValue = filteredData.map({ $0.value }).sorted().last ?? 0
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 3) {
            ForEach(datas) { data in
                RoundedRectangle(cornerRadius: 4).fill(grassColor(data: data))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
    
    func grassColor(data: GrassData) -> Color {
        if data.value == 0 {
            return Color.black.opacity(0.2)
        }
        
        return .green.opacity(data.value / self.highestValue)
    }
    
    static func getHistoryGrassData(from histories: [ExerciseHistory]) -> [GrassData] {
        let row = 5
        let item = 20
        let itemCount = row * item
        guard let startDate = subtractDays(from: Date(), numberOfDays: itemCount - 1) else { return [] }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dates = generateDates(startingFrom: startDate, numberOfDays: itemCount).compactMap({ dateFormatter.string(from: $0)})
        var datas: [GrassData] = dates.map({ date in
            guard let history = histories.first(where: { $0.date == date }) else { return .init(date: date, value: 0) }
            return .init(date: date, value: history.volume)
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
