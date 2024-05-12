//
//  HeatmapColorData.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

enum HeatmapColorData: String, Codable {
    case green
    case blue
    case red
    case pink
    case purple
    case yellow
    case orange
    case brown
    case cyan
    case mint
    
    init(color: HeatmapColorDomain) {
        switch color {
        case .green:
            self = .green
        case .blue:
            self = .blue
        case .red:
            self = .red
        case .pink:
            self = .pink
        case .purple:
            self = .purple
        case .yellow:
            self = .yellow
        case .orange:
            self = .orange
        case .brown:
            self = .brown
        case .cyan:
            self = .cyan
        case .mint:
            self = .mint
        }
    }
    
    var domain: HeatmapColorDomain {
        switch self {
        case .green:
            return .green
        case .blue:
            return .blue
        case .red:
            return .red
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .yellow:
            return .yellow
        case .orange:
            return .orange
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .mint:
            return .mint
        }
    }
}
