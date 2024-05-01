//
//  HeatmapRepositoryTest.swift
//  dg-muscle-iosTests
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

final class HeatmapRepositoryTest: HeatmapRepository {
    var heatmapColor: HeatmapColorDomain { _heatmapColor }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { $_heatmapColor.eraseToAnyPublisher() }
    @Published private var _heatmapColor: HeatmapColorDomain = .green
    
    func post(data: HeatmapColorDomain) throws {
        
    }
    
    func post(data: [HeatmapDomain]) throws {
        
    }
}
