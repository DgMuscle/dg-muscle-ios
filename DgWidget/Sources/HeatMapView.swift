//
//  HeatMapView.swift
//  DgWidget
//
//  Created by 신동규 on 6/9/24.
//

import SwiftUI
import Domain
import HistoryHeatMap
import DataLayer

struct HeatMapView: View {
    
    let repository: HeatMapRepository
    let heatMap: [HistoryHeatMap.HeatMap]
    let heatmapColor: Domain.HeatMapColor
    
    init() {
        repository = HeatMapRepositoryImpl.shared
        heatMap = repository.get().map({ .init(domain: $0) })
        heatmapColor = (try? repository.get()) ?? .green
    }
    
    var body: some View {
        HistoryHeatMap.HeatMapView(heatMap: heatMap, color: convert(color: heatmapColor))
    }
    
    func convert(color: Domain.HeatMapColor) -> Color {
        switch color {
            
        case .green:
            return .green
        case .blue:
            return .blue
        case .red:
            return .red
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .mint:
            return .mint
        }
    }
}
