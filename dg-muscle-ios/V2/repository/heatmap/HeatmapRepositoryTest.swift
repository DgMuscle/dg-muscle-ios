//
//  HeatmapRepositoryTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import SwiftUI

final class HeatmapRepositoryTest: HeatmapRepository {
    func get() -> Color {
        return .blue
    }
    
    func post(color: HeatmapColor) throws {
        
    }
}
