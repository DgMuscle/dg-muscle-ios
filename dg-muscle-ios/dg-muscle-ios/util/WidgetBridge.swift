//
//  WidgetBridge.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/23/23.
//

import Foundation

struct GrassDatasourceBridge {
    let date: String
    let volume: Double
}

final class WidgetBridge {
    static let shared = WidgetBridge()
    
    private init() { }
    
    func save(data: [GrassDatasourceBridge]) {
        
    }
    
    func get() -> [GrassDatasourceBridge] {
        []
    }
}
