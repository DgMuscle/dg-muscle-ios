//
//  HeatmapRepositoryData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine
import WidgetKit

final class HeatmapRepositoryData: HeatmapRepository {
    static let shared = HeatmapRepositoryData()
    var heatmapColor: HeatmapColorDomain { _heatmapColor }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { $_heatmapColor.eraseToAnyPublisher() }
    @Published private var _heatmapColor: HeatmapColorDomain
    
    private init() {
        let heatmapColorData = (try? FileManagerHelperV2.shared.load(HeatmapColorData.self, fromFile: .heatmapColor)) ?? .green
        _heatmapColor = heatmapColorData.domain
    }
    
    func post(data: HeatmapColorDomain) throws {
        _heatmapColor = data
        let data: HeatmapColorData = .init(color: data)
        try FileManagerHelperV2.shared.save(data, toFile: .heatmapColor)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func post(data: [HeatmapDomain]) throws {
        let heatmapData: [HeatmapData] = data.map({ .init(from: $0) })
        try FileManagerHelperV2.shared.save(heatmapData, toFile: .heatmap)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
