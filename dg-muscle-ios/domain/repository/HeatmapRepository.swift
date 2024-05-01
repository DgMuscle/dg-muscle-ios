//
//  HeatmapRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

protocol HeatmapRepository {
    var heatmapColor: HeatmapColorDomain { get }
    var heatmapColorPublisher: AnyPublisher<HeatmapColorDomain, Never> { get }
    func post(data: HeatmapColorDomain) throws
    func post(data: [HeatmapDomain]) throws
}
