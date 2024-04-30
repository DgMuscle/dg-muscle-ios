//
//  FileUploaderTest.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/17/24.
//

import UIKit

final class FileUploaderTest: FileUploaderInterface {
    func uploadImage(path: String, image: UIImage) async throws -> URL {
        throw ErrorData.invalidUrl
    }
    
    func deleteImage(path: String) async throws {
        
    }
}
