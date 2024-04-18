//
//  HeatmapRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Combine

protocol HeatmapRepository {
    var color: HeatmapColor { get }
    var colorPublisher: AnyPublisher<HeatmapColor, Never> { get }
    
    func post(color: HeatmapColor) throws
}
