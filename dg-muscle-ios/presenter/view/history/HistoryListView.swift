//
//  HistoryListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI

struct HistoryListView: View {
    
    let today: Date
    let historyRepository: HistoryRepository
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 60)
            
            Button {
                print("heatmap")
            } label: {
                HeatmapView(viewModel: .init(subscribeHeatmapUsecase: subscribeHeatmapUsecase,
                                             subscribeHeatmapColorUsecase: subscribeHeatmapColorUsecase))
            }
            
        }
        .scrollIndicators(.hidden)
    }
    
    var subscribeHeatmapUsecase: SubscribeHeatmapUsecase {
        .init(historyRepository: historyRepository, today: today)
    }
    
    var subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase {
        .init(historyRepository: historyRepository)
    }
}

#Preview {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let today = dateFormatter.date(from: "20240415")!
    
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    
    return HistoryListView(today: today, historyRepository: historyRepository)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
