//
//  HistoryNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation

public struct HistoryNavigation: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.rawValue.hashValue)
    }
    
    public init(name: Name) {
        self.name = name
    }
    
    let name: Name
}

extension HistoryNavigation {
    public enum Name: String {
        case heatMapColor
    }
}
