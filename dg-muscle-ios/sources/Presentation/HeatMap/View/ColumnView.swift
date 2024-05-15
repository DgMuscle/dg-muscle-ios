//
//  ColumnView.swift
//  HeatMap
//
//  Created by 신동규 on 5/15/24.
//

import SwiftUI

struct ColumnView: View {
    
    let heatMap: HeatMapData
    let maxVolume: Double
    let color: Color
    
    private let size: CGFloat = 15
    
    var body: some View {
        VStack(spacing: 3) {
            ForEach(heatMap.volume, id: \.self) { volume in
                if volume.value == 0 {
                    RoundedRectangle(cornerRadius: 2).fill(.gray).opacity(0.2)
                        .frame(width: size, height: size)
                } else {
                    RoundedRectangle(cornerRadius: 2).fill(color).opacity(volume.value / maxVolume)
                        .frame(width: size, height: size)
                    
                }
            }
        }
    }
}
