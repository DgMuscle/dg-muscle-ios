//
//  VerticalVolumeBarChartView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import SwiftUI
import Charts

struct VerticalVolumeBarChartView: View {
    
    var datas: [MonthlySectionViewModel.Data]
    
    var body: some View {
        Chart {
            ForEach(datas, id: \.self) { data in
                BarMark(
                    x: .value("Exercise Part", data.part.rawValue.capitalized),
                    y: .value("Exercise Volume", data.volume)
                )
                .foregroundStyle(
                    LinearGradient(colors: [.blue.opacity(0.4), .blue], startPoint: .bottom, endPoint: .top)
                )
            }
        }
    }
}

#Preview {
    let data1: MonthlySectionViewModel.Data = .init(part: .leg, volume: 11900)
    let data2: MonthlySectionViewModel.Data = .init(part: .chest, volume: 6000)
    let data3: MonthlySectionViewModel.Data = .init(part: .back, volume: 7000)
    
    let datas = [data1, data2, data3]
    
    return VerticalVolumeBarChartView(datas: datas)
        .preferredColorScheme(.dark)
}
