//
//  FileUploader.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import UIKit
import FirebaseStorage

final class FileUploader: FileUploaderInterface {
    static let shared = FileUploader()
    
    private let storage = Storage.storage()
    private init() { }
    
    func uploadImage(path: String, image: UIImage) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            guard let data = image.pngData() else {
                continuation.resume(throwing: CustomError.unknown)
                return
            }
            let ref = storage.reference().child(path)
            
            ref.putData(data) { _, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    ref.downloadURL { url, error in
                        if let url {
                            continuation.resume(returning: url)
                        } else if let error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(throwing: CustomError.unknown)
                        }
                    }
                }
            }
        }
    }
    
    func deleteImage(path: String) async throws {
        let ref = storage.reference().child(path)
        try await ref.delete()
    }
}
