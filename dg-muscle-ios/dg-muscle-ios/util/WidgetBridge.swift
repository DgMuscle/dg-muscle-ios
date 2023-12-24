//
//  WidgetBridge.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 12/23/23.
//

import Foundation

struct GrassDatasourceBridge: Codable {
    let date: String
    let volume: Double
}

final class WidgetBridge {
    static let shared = WidgetBridge()
    
    private init() { }
    
    func save(data: [GrassDatasourceBridge]) throws {
        try FileManagerHelper.save(data, toFile: .grassDatasourceBridge)
    }
    
    func get() -> [GrassDatasourceBridge] {
        do {
            return try FileManagerHelper.load([GrassDatasourceBridge].self, fromFile: .grassDatasourceBridge)
        } catch {
            return []
        }
    }
}
