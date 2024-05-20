//
//  HistoryNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation

struct HistoryNavigation: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.rawValue.hashValue)
    }
    
    let name: Name
}

extension HistoryNavigation {
    enum Name: String {
        case heatMapColor
    }
}
