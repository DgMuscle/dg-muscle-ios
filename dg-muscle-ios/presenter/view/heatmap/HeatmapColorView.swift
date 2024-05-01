//
//  HeatmapColorView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import SwiftUI

struct HeatmapColorView: View {
    
    @StateObject var viewModel: HeatmapColorViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 50, maximum: 100))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10, content: {
                ForEach(viewModel.allColors, id: \.self) { color in
                    Button {
                        viewModel.updateColor(color: color)
                    } label: {
                        RoundedRectangle(cornerRadius: 8).fill(color.color)
                            .frame(height: 50)
                    }
                }
            })
            RoundedRectangle(cornerRadius: 8).fill(viewModel.selectedColor.color)
        }
        .animation(.default, value: viewModel.selectedColor)
    }
}

#Preview {
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let viewModel: HeatmapColorViewModel = .init(postHeatmapColorUsecase: .init(historyRepository: historyRepository),
                                                 subscribeHeatmapColorUsecase: .init(historyRepository: historyRepository),
                                                 getHeatmapColorUsecase: .init(historyRepository: historyRepository))
    return HeatmapColorView(viewModel: viewModel).preferredColorScheme(.dark)
}
