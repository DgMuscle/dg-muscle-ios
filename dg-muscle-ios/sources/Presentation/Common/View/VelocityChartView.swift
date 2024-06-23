//
//  VelocityChartView.swift
//  Common
//
//  Created by 신동규 on 6/23/24.
//

import SwiftUI
import Charts
import MockData
import Domain

public struct VelocityChartView: View {
    
    public let data: [RunPiece]
    
    public init(data: [RunPiece]) {
        
        if data.isEmpty {
            self.data = []
            return
        }
        
        var data = data
        
        if data.count < 2 {
            data.append(data[0])
        }
        
        self.data = data
    }
    
    public var body: some View {
        Chart {
            ForEach(data, id: \.self) { item in
                LineMark(
                    x: .value("time", item.start),
                    y: .value("velocity", item.velocity)
                )
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("time", item.start),
                    y: .value("velocity", item.velocity)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue.opacity(0.1), .blue.opacity(0.3)],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    VelocityChartView(
        data: HISTORY_1.run!.pieces.map({
            .init(
                domain: $0
            )
        })
    )
    .preferredColorScheme(
        .dark
    )
}

