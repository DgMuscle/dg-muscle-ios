//
//  HeatmapView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HeatmapView: View {
    
    @StateObject var viewModel: HeatmapViewModel
    
    var body: some View {
        HeatMap(datas: viewModel.datas, color: viewModel.color)
    }
}

#Preview {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240415")!
    let repository = HistoryRepositoryTest()
    let heatmapRepository: HeatmapRepository = HeatmapRepositoryTest()
    let heatmapUsecase = SubscribeHeatmapUsecase(historyRepository: repository,
                                                 today: date,
                                                 heatmapRepository: heatmapRepository)
    let colorUsecase = SubscribeHeatmapColorUsecase(heatmapRepository: heatmapRepository)
    
    let viewModel: HeatmapViewModel = .init(subscribeHeatmapUsecase: heatmapUsecase,
                                            subscribeHeatmapColorUsecase: colorUsecase)
    
    return HeatmapView(viewModel: viewModel).preferredColorScheme(.dark)
}