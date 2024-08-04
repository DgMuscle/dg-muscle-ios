//
//  PostProfilePhotoUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import UIKit

public final class PostProfilePhotoUsecase {
    private let userRepository: UserRepository
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    public func implement(photo: UIImage?) async throws {
        try await userRepository.updateUser(photo: photo)
    }
}
