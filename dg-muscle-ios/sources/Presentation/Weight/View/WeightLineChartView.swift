//
//  WeightLineChartView.swift
//  App
//
//  Created by 신동규 on 8/6/24.
//

import SwiftUI
import Charts

struct WeightLineChartView: View {
    
    let data: [WeightPresentation]
    
    private let dotSize: CGFloat = 6
    private let cellSize: CGFloat = 30
    
    var body: some View {
        Chart(data, id: \.self) { data in
            LineMark(x: .value("date", data.date, unit: .day),
                     y: .value("weight", data.value))
            .interpolationMethod(.catmullRom)
            .symbol {
                Circle()
                    .frame(width: dotSize, height: dotSize)
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartScrollPosition(initialX: Int.max)
        .frame(height: 300)
        .chartYScale(domain: 50...80) // 범위 구하는 UseCase 추가 필요
    }
}
