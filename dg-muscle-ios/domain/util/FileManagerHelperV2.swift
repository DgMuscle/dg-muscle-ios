//
//  FileManagerHelperV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/27/24.
//

import Foundation

final class FileManagerHelperV2 {
    static let shared = FileManagerHelperV2()
    private let documentsDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.donggyu.dg-muscle-ios")!
    private init() { }
    
    func save<T: Codable>(_ object: T, toFile fileName: File) throws {
        let filePath = documentsDirectory.appendingPathComponent(fileName.rawValue)
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        try data.write(to: filePath)
    }
    
    func load<T: Codable>(_ type: T.Type, fromFile fileName: File) throws -> T {
        let filePath = documentsDirectory.appendingPathComponent(fileName.rawValue)
        let data = try Data(contentsOf: filePath)
        let decoder = JSONDecoder()
        let object = try decoder.decode(type, from: data)
        return object
    }
    
    func delete(withName fileName: File) throws {
        let filePath = documentsDirectory.appendingPathComponent(fileName.rawValue)
        try FileManager.default.removeItem(at: filePath)
    }
    
}

extension FileManagerHelperV2 {
    enum File: String, CaseIterable {
        case userV2
        case dguserV2
        case historyV2
        case exerciseV2
        case workoutMetaDataV2
        case grassDatasourceBridgeV2
        case workoutHeatMapDataV2
        case heatmapColorV2
    }
}
