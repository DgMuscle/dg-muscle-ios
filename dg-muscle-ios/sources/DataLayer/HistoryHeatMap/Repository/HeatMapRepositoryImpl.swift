//
//  HeatMapRepositoryImpl.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Domain

public final class HeatMapRepositoryImpl: HeatMapRepository {
    public static let shared = HeatMapRepositoryImpl()
    
    private init() { }
    
    public func get() -> [Domain.HeatMap] {
        let heatMap: [HeatMap] = (try? FileManagerHelper.shared.load([HeatMap].self, fromFile: .heatmap)) ?? []
        return heatMap.map({ $0.domain })
    }
    
    public func post(heatMap: [Domain.HeatMap]) {
        let heatMap: [HeatMap] = heatMap.map({ .init(domain: $0) })
        DispatchQueue.global(qos: .background).async {
            try? FileManagerHelper.shared.save(heatMap, toFile: .heatmap)
        }
    }
    
    public func get() throws -> Domain.HeatMapColor {
        let data = try FileManagerHelper.shared.load(HeatMapColor.self, fromFile: .heatmapColor)
        return data.domain
    }
}
