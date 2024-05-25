//
//  PostBackgroundImageUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import UIKit

public final class PostBackgroundImageUsecase {
    private let userRepository: UserRepository
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    public func implement(backgroundImage: UIImage?) async throws {
        try await userRepository.updateUser(backgroundImage: backgroundImage)
    }
}
