//
//  WorkoutHeatMapCommonView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/16/24.
//

import SwiftUI

struct WorkoutHeatMapCommonView: View {
    
    var datas: [WorkoutHeatMapViewModel.Data]
    var heatColor: HeatmapColor
    
    var maxVolume: Double {
        datas.flatMap({ $0.volumes }).map({ $0.value }).max() ?? 0
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 3.5) {
            ForEach(datas) { data in
                HeatMapColumnView(data: data, maxVolume: maxVolume, heatColor: heatColor)
            }
        }
    }
}
