//
//  HeatmapRepositoryTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Combine

final class HeatmapRepositoryTest: HeatmapRepository {
    var color: HeatmapColor { _color }
    
    var colorPublisher: AnyPublisher<HeatmapColor, Never> {
        $_color.eraseToAnyPublisher()
    }
    
    @Published private var _color: HeatmapColor = .blue
    
    
    func post(color: HeatmapColor) throws {
        
    }
}
