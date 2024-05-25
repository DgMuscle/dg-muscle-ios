//
//  FirestoreFileUploader.swift
//  DataLayer
//
//  Created by 신동규 on 5/25/24.
//

import FirebaseStorage
import UIKit

final class FirestoreFileUploader {
    static let shared = FirestoreFileUploader()
    
    private let storage = Storage.storage()
    private init() { }
    
    func uploadImage(path: String, image: UIImage) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            guard let data = image.pngData() else {
                continuation.resume(throwing: DataError.unknown)
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
                            continuation.resume(throwing: DataError.unknown)
                        }
                    }
                }
            }
        }
    }
    
    func deleteImage(path: String) async throws {
        if let url = URL(string: path) {
            let pathComponents = url.pathComponents
            
            // 필요한 경로 부분만 추출합니다. "o" 다음 부분부터 마지막까지의 경로를 가져옵니다.
            if let startIndex = pathComponents.firstIndex(of: "o") {
                let relevantPathComponents = pathComponents[(startIndex + 1)...]  // "o" 다음부터 모든 요소
                let formattedPath = relevantPathComponents.joined(separator: "/")  // 배열을 문자열로 합칩니다.
                let ref = storage.reference().child(formattedPath)
                try await ref.delete()
            }
            
        } else {
            let ref = storage.reference().child(path)
            try await ref.delete()
        }
    }
}
