//
//  WorkoutHeatMapViewForWidget.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/15/24.
//

import SwiftUI

struct WorkoutHeatMapViewForWidget: View {
    
    @State var datas: [WorkoutHeatMapViewModel.Data] = (try? HistoryRepositoryV2Impl.shared.get()) ?? []
    
    var maxVolume: Double {
        datas.flatMap({ $0.volumes }).map({ $0.value }).max() ?? 0
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            ForEach(datas) { data in
                HeatMapColumnView(data: data, maxVolume: maxVolume)
            }
        }
    }
}
