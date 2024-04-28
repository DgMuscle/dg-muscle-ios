//
//  HeatmapColumn.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HeatmapColumn: View {
    
    var data: HeatmapV
    var maxVolume: Double
    var color: HeatmapColorV
    
    private let size: CGFloat = 15
    
    var body: some View {
        VStack(spacing: 3) {
            ForEach(data.volumes) { volume in
                if volume.value == 0 {
                    RoundedRectangle(cornerRadius: 2).fill(.gray).opacity(0.2)
                        .frame(width: size, height: size)
                } else {
                    RoundedRectangle(cornerRadius: 2).fill(color.color).opacity(volume.value / maxVolume)
                        .frame(width: size, height: size)
                }
            }
        }
    }
}
