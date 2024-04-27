//
//  HeatmapColorV.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

enum HeatmapColorV: String {
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
