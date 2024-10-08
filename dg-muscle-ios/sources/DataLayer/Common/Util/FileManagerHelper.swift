//
//  FileManagerHelper.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

final class FileManagerHelper {
    static let shared = FileManagerHelper()
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
    
    func deleteAll() throws {
        for file in File.allCases {
            let filePath = documentsDirectory.appendingPathComponent(file.rawValue)
            try FileManager.default.removeItem(at: filePath)
        }
    }
}

extension FileManagerHelper {
    enum File: String, CaseIterable {
        case history
        case exercise
        case exerciseTimer
        case historyMetaData
        case heatmapColor
        case heatmap
    }
}
