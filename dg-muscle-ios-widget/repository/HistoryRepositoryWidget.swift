//
//  HistoryRepositoryWidget.swift
//  dg-muscle-ios-widgetExtension
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

final class HistoryRepositoryWidget: HistoryRepository {
    static let shared = HistoryRepositoryWidget()
    var histories: [HistoryDomain] { _histories }
    var historiesPublisher: AnyPublisher<[HistoryDomain], Never> { $_histories.eraseToAnyPublisher() }
    @Published private var _histories: [HistoryDomain]
    
    var heatmapColor: HeatmapColorDomain { _heatmapColor }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { $_heatmapColor.eraseToAnyPublisher() }
    @Published private var _heatmapColor: HeatmapColorDomain
    
    private init() {
        _histories = Self.getHistoriesFromFile()
        _heatmapColor = Self.getColorFromFile()
    }
    
    func post(data: HistoryDomain) async throws {
        
    }
    
    func post(data: HeatmapColorDomain) throws {
        
    }
    
    func delete(data: HistoryDomain) async throws {
        
    }
    
    static private func getHistoriesFromFile() -> [HistoryDomain] {
        let historyDatas: [HistoryData] = (try? FileManagerHelperV2.shared.load([HistoryData].self, fromFile: .history)) ?? []
        return historyDatas.map { $0.domain }
    }
    
    static private func getColorFromFile() -> HeatmapColorDomain {
        let data: HeatmapColorData = (try? FileManagerHelperV2.shared.load(HeatmapColorData.self, fromFile: .heatmapColor)) ?? .green
        return data.domain
    }
}
