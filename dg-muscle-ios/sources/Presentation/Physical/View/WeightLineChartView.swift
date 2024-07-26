//
//  WeightLineChartView.swift
//  App
//
//  Created by Donggyu Shin on 7/26/24.
//

import SwiftUI

struct WeightLineChartView: View {
    
    let data: [WeightPresentation]
    
    var body: some View {
        Text("WeightLineChartView")
    }
}

#Preview {
    
    func generateSampleDate(dateString: String) -> Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let generatedDate = dateFormatter.date(from: dateString) {
            date = generatedDate
        }
        return date
    }
    
    let dateStrings: [String] = [
    "20240701",
    "20240702",
    "20240703",
    "20240704",
    "20240705",
    "20240706",
    "20240707",
    "20240708",
    "20240709",
    "20240710",
    "20240711",
    "20240712",
    "20240713",
    "20240714",
    "20240715",
    "20240716",
    "20240717",
    "20240718",
    "20240719",
    "20240720",
    "20240721",
    "20240722",
    "20240723",
    "20240724",
    "20240725",
    "20240726",
    "20240727",
    "20240728",
    "20240729",
    "20240730",
    ]
    
    let data: [WeightPresentation] = dateStrings.map({
        .init(date: generateSampleDate(dateString: $0), 
              value: 70,
              unit: .kg)
    })
    
    return WeightLineChartView(data: data)
        .preferredColorScheme(.dark)
}
