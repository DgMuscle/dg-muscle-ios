//
//  HeatmapRepository.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import SwiftUI

protocol HeatmapRepository {
    func get() -> Color
    func post(color: HeatmapColor) throws
}
