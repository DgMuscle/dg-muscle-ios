//
//  HistoryGrassView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/15/23.
//

import SwiftUI

struct HistoryGrassView: View {
    
    @State var datas: [Data]
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 4), count: 15)
    
    private let averageValue: Double
    
    init(datas: [Data]) {
        _datas = .init(initialValue: datas)
        let filteredData = datas.filter({ $0.value > 0 })
        let sum = filteredData.reduce(0, { $0 + $1.value })
        averageValue = sum / Double(filteredData.count)
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 4) {
            ForEach(datas) { data in
                RoundedRectangle(cornerRadius: 4).fill(grassColor(data: data))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemBackground))
        }
    }
    
    func grassColor(data: Data) -> Color {
        if data.value == 0 {
            return .secondary.opacity(0.4)
        }
        
        if data.value >= self.averageValue {
            return .green.opacity(0.8)
        } else {
            return .green.opacity(0.5)
        }
    }
}

extension HistoryGrassView {
    struct Data: Identifiable {
        let id = UUID().uuidString
        let date: String
        let value: Double
    }
}
