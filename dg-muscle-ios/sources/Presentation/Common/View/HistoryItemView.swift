//
//  HistoryItemView.swift
//  Presentation
//
//  Created by 신동규 on 6/14/24.
//

import SwiftUI
import MapKit

public struct HistoryItemView: View {
    
    let history: HistoryItem
    
    public init(history: HistoryItem) {
        self.history = history
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                coloredText
                
                HStack {
                    if let seconds = history.time {
                        Text("Duration: \(time(seconds: seconds))")
                    }
                    
                    if let kcal = history.kcal {
                        Text("(\(Int(kcal)) kcal)")
                    }
                }
                .foregroundStyle(Color(uiColor: .secondaryLabel)).italic()
                .font(.caption2)
                .padding(.top, 1)
            }
            .foregroundStyle(Color(uiColor: .label))
            Spacer()
        }
        
    }
    
    var coloredText: some View {
        
        if history.parts.isEmpty {
            return VStack {
                Text("On the \(day(date: history.date))th, I worked out as much as ") +
                Text("\(Int(history.volume))").fontWeight(.bold).foregroundStyle(history.color) +
                Text(runText(runDistance: history.runDistance))
            }
            .multilineTextAlignment(.leading)
        } else {
            let partTexts = history.parts.map({ part in
                Text(part.capitalized).fontWeight(.bold).foregroundStyle(history.color)
            })
            
            var combinedPartTexts = Text("")
            
            for (index, partText) in partTexts.enumerated() {
                let isLast = index == partTexts.count - 1
                combinedPartTexts = combinedPartTexts + partText + (isLast ? Text("") : Text(" and "))
            }
            
            return VStack {
                Text("On the \(day(date: history.date))th, I worked out my ") +
                combinedPartTexts +
                Text(" as much as ") +
                Text("\(Int(history.volume))").fontWeight(.bold) +
                Text(runText(runDistance: history.runDistance))
            }
            .multilineTextAlignment(.leading)
        }
    }
    
    private func runText(runDistance: Double?) -> String {
        var result = ""
        
        if let runDistance {
            result = ", run \(MKDistanceFormatter().string(fromDistance: runDistance))"
        }
        
        return result
    }
    
    private func day(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    private func time(seconds: Double) -> String {
        let seconds = Int(seconds)
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        var timeString = ""
        if hours > 0 {
            timeString += "\(hours)h "
        }
        if minutes > 0 {
            timeString += "\(minutes)m "
        }
        if remainingSeconds > 0 || (hours == 0 && minutes == 0) {
            timeString += "\(remainingSeconds)s"
        }
        return timeString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    let history: HistoryItem = .init(
        id: UUID().uuidString,
        date: Date(),
        parts: [
            "leg",
            "chest"
        ],
        volume: 6890,
        color: .blue,
        time: 1500,
        kcal: 500,
        runDistance: 3600
    )
    
    return HistoryItemView(history: history).preferredColorScheme(.dark)
}

