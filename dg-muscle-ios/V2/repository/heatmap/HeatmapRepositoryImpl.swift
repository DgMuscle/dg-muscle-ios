//
//  HeatmapRepositoryImpl.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Foundation
import SwiftUI

final class HeatmapRepositoryImpl: HeatmapRepository {
    func get() -> Color {
        do {
            let heatmapColor = try FileManagerHelper.load(HeatmapColor.self, fromFile: .heatmapColor)
            return heatmapColor.color
        } catch {
            return .green
        }
    }
    
    func post(color: HeatmapColor) throws {
        try FileManagerHelper.save(color, toFile: .heatmapColor)
    }
}
