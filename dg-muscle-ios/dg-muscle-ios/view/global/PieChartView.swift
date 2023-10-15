//
//  PieChartView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/15/23.
//

import SwiftUI
import Charts

struct PieChartView: View {
    @State var datas: [Data]
    var body: some View {
        Chart(datas.sorted(by: { $0.name < $1.name })) { data in
            SectorMark(
                angle: .value(data.name, data.value),
                innerRadius: .ratio(0.618),
                angularInset: 1.5
            )
            .cornerRadius(4)
            .foregroundStyle(by: .value("Part", data.name))
        }
        .chartXAxis(.hidden)
    }
}

extension PieChartView {
    struct Data: Identifiable {
        let id = UUID().uuidString
        let name: String
        let value: Double
    }
}
