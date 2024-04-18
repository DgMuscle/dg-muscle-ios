//
//  HeatmapRepositoryImpl.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Combine

final class HeatmapRepositoryImpl: HeatmapRepository {
    static let shared = HeatmapRepositoryImpl()
    
    var color: HeatmapColor { _color }
    
    var colorPublisher: AnyPublisher<HeatmapColor, Never> {
        $_color.eraseToAnyPublisher()
    }
    
    @Published private var _color: HeatmapColor = .green
    
    private init() {
        configureColor()
    }
    
    func post(color: HeatmapColor) throws {
        _color = color
        try FileManagerHelper.save(color, toFile: .heatmapColor)
    }
    
    private func configureColor() {
        _color = (try? FileManagerHelper.load(HeatmapColor.self, fromFile: .heatmapColor)) ?? .green
    }
}
