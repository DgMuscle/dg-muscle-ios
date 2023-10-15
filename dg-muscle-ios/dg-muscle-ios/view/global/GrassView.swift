//
//  HistoryGrassView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/15/23.
//

import SwiftUI

struct GrassView: View {
    
    @State var datas: [Data]
    
    var columns: [GridItem]
    
    private let averageValue: Double
    private let highestValue: Double
    
    init(datas: [Data], count: Int) {
        _datas = .init(initialValue: datas)
        self.columns = Array(repeating: .init(.flexible(), spacing: 3), count: count)
        let filteredData = datas.filter({ $0.value > 0 })
        let sum = filteredData.reduce(0, { $0 + $1.value })
        averageValue = sum / Double(filteredData.count)
        self.highestValue = filteredData.map({ $0.value }).sorted().last ?? 0
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 3) {
            ForEach(datas) { data in
                RoundedRectangle(cornerRadius: 4).fill(grassColor(data: data))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
    
    func grassColor(data: Data) -> Color {
        if data.value == 0 {
            return Color.black.opacity(0.2)
        }
        
        return .green.opacity(data.value / self.highestValue)
    }
}

extension GrassView {
    struct Data: Identifiable {
        let id = UUID().uuidString
        let date: String
        let value: Double
    }
}
