//
//  HeatMapView.swift
//  HeatMap
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI

public struct HeatMapView: View {
    let heatMap: [HeatMapData]
    let color: Color
    let maxVolume: Double
    
    public init(heatMap: [HeatMapData], color: Color) {
        self.heatMap = heatMap
        self.color = color
        self.maxVolume = heatMap.flatMap({ $0.volume }).map({ $0.value }).max() ?? 0
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 3.5) {
            ForEach(heatMap, id: \.self) { heatMap in
                ColumnView(heatMap: heatMap, maxVolume: maxVolume, color: color)
            }
        }
    }
}
