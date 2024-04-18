//
//  HeatmapColor.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import SwiftUI

enum HeatmapColor: Codable, CaseIterable {
    case green
    case mint
    case blue
    case red
    case pink
    case yellow
    case orange
    case brown
    case cyan
    case purple
    
    var color: Color {
        switch self {
        case .green:
            return .green
        case .mint:
            return .mint
        case .blue:
            return .blue
        case .red:
            return .red
        case .pink:
            return .pink
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .purple:
            return .purple
        }
    }
}
