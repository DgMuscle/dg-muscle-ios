//
//  WorkoutHeatMapView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/15/24.
//

import SwiftUI

struct WorkoutHeatMapView: View {
    
    @StateObject var viewModel: WorkoutHeatMapViewModel
    
    var body: some View {
        WorkoutHeatMapCommonView(datas: viewModel.datas, 
                                 heatColor: viewModel.heatmapColor)
    }
}

#Preview {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240415")!
    
    let viewModel: WorkoutHeatMapViewModel = .init(historyRepository: HistoryRepositoryV2Test(), 
                                                   today: date,
                                                   heatmapRepository: HeatmapRepositoryTest())
    
    return WorkoutHeatMapView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
