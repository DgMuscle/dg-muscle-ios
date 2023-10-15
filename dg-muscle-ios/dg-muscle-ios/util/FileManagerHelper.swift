//
//  FileManagerHelper.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/8/23.
//

import Foundation

class FileManagerHelper {
    static let documentsDirectory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.donggyu.dg-muscle-ios")!
    
    static func save<T: Codable>(_ object: T, toFile fileName: String) throws {
        let filePath = documentsDirectory.appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        try data.write(to: filePath)
    }
    
    static func load<T: Codable>(_ type: T.Type, fromFile fileName: String) throws -> T {
        let filePath = documentsDirectory.appendingPathComponent(fileName)
        let data = try Data(contentsOf: filePath)
        let decoder = JSONDecoder()
        let object = try decoder.decode(type, from: data)
        return object
    }
}
