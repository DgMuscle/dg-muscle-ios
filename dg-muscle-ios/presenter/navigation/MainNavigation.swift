//
//  MainNavigation.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct MainNavigationV2: Identifiable, Hashable {
    enum Name: String {
        case setting
        case heatmapColor
        case profile
        case profilePhoto
        case openWeb
    }
    
    var id: Int { name.hashValue }
    let name: Name
    var openWebUrl: String? = nil
    
    init(name: Name) {
        self.name = name
    }
    
    init(openWeb: String) {
        self.name = .openWeb
        self.openWebUrl = openWeb
    }
}
