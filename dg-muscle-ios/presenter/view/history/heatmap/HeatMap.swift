//
//  HeatMap.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HeatMap: View {
    
    var datas: [HeatmapV]
    var color: HeatmapColorV
    
    var maxVolume: Double {
        datas.flatMap({ $0.volumes }).map({ $0.value }).max() ?? 0
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 3.5) {
            ForEach(datas) { data in
                HeatmapColumn(data: data, maxVolume: maxVolume, color: color)
            }
        }
    }
}
