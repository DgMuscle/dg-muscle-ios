//
//  WeightLineChartView.swift
//  App
//
//  Created by 신동규 on 8/6/24.
//

// https://swiftwithmajid.com/2023/07/18/mastering-charts-in-swiftui-selection/

import SwiftUI
import Charts
import MockData
import Domain

struct WeightLineChartView: View {
    
    @ObservedObject var viewModel: WeightLineChartViewModel
    
    init(
        weightRepository: WeightRepository,
        weights: [WeightPresentation],
        range: (Double, Double)
    ) {
        _viewModel = .init(wrappedValue: .init(
            weightRepository: weightRepository,
            weights: weights,
            range: range
        ))
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
            
            if let selectedWeight = viewModel.selectedWeight {
                RuleMark(
                    x: .value("date", selectedWeight.date, unit: .day),
                    yStart: .value("weight", selectedWeight.value),
                    yEnd: .value("weight", max(selectedWeight.value, viewModel.range.1 - 1))
                )
                .annotation(position: .top) {
                    VStack {
                        Text("\(String(selectedWeight.value))kg")
                            .bold()
                        Text(dateString(date: selectedWeight.date))
                            .italic()
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .secondarySystemBackground))
                    }
                    .offset(y: 40)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month))
        }
        .chartXSelection(value: $viewModel.selectedDate)
        .chartScrollableAxes(.horizontal)
        .chartScrollPosition(initialX: Date())
        .chartYScale(domain: viewModel.range.0...viewModel.range.1)
        .frame(height: 360)
    }
    
    private func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.dd"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    
    let repository = WeightRepositoryMock()
    let weights = GetWeightsWithoutDuplicatesUsecase().implement(weights: repository.get())
    let range = GetWeightsRangeUsecase().implement(weights: weights)
    
    return WeightLineChartView(
        weightRepository: repository,
        weights: weights.map({ .init(domain: $0) }),
        range: range
    )
    .preferredColorScheme(.dark)
}
