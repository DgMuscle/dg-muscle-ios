//
//  WeightLineChartView.swift
//  App
//
//  Created by 신동규 on 8/6/24.
//

import SwiftUI
import Charts
import MockData
import Domain

struct WeightLineChartView: View {
    
    @StateObject var viewModel: WeightLineChartViewModel
    
    init(weightRepository: WeightRepository) {
        _viewModel = .init(wrappedValue: .init(weightRepository: weightRepository))
    }
    
    private let dotSize: CGFloat = 6
    private let cellSize: CGFloat = 30
    
    var body: some View {
        Chart(viewModel.weights, id: \.self) { data in
            LineMark(x: .value("date", data.date, unit: .day),
                     y: .value("weight", data.value))
            .interpolationMethod(.catmullRom)
            .symbol {
                Circle().frame(width: dotSize, height: dotSize)
            }
            
            AreaMark(
                x: .value("date", data.date, unit: .day),
                y: .value("weight", data.value)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(
                LinearGradient(
                    colors: [.blue.opacity(0.1), .blue.opacity(1)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .chartScrollableAxes(.horizontal)
        .chartScrollPosition(initialX: Int.max)
        .frame(height: 300)
        .chartYScale(domain: viewModel.range.0...viewModel.range.1)
    }
}

#Preview {
    return WeightLineChartView(weightRepository: WeightRepositoryMock())
        .preferredColorScheme(.dark)
}
