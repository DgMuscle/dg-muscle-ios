//
//  MainNavigationV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

struct MainNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case setting
        case heatmapColor
    }
    
    var id: Int { name.hashValue }
    let name: Name
}

struct HistoryNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case historyForm
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var id: Int { name.hashValue }
    let name: Name
    let historyFormParameter: HistoryV?
    
    init(historyForm history: HistoryV?) {
        name = .historyForm
        historyFormParameter = history
    }
}
