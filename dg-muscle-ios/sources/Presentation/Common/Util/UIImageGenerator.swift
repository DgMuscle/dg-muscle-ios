//
//  UIImageGenerator.swift
//  Common
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Kingfisher
import UIKit

public final class UIImageGenerator {
    public static let shared = UIImageGenerator()
    private init() { }
    
    public func generateImageFrom(url: URL) async throws -> UIImage? {
        return try await withCheckedThrowingContinuation { continuation in
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let successResult):
                    continuation.resume(returning: successResult.image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
