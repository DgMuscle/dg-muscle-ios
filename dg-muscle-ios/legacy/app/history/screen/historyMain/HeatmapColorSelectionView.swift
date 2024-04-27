//
//  HeatmapColorSelectionView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import SwiftUI

struct HeatmapColorSelectionView: View {
    @StateObject var viewModel: HeatmapColorSelectionViewModel
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 50, maximum: 100))
    ]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10, content: {
                ForEach(viewModel.allColors, id: \.self) { color in
                    Button {
                        viewModel.tap(color: color)
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
    let viewModel: HeatmapColorSelectionViewModel = .init(heatmapRepository: HeatmapRepositoryTest())
    return HeatmapColorSelectionView(viewModel: viewModel).preferredColorScheme(.dark)
}
