//
//  PostUserProfileImageUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import UIKit

final class PostUserProfileImageUsecase {
    let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func implement(data: UIImage) {
        Task {
            guard let user = userRepository.user else { return }
            let path = "profilePhoto/\(user.uid)/\(UUID().uuidString).png"
            let url = try await FileUploader.shared.uploadImage(path: path, image: data)
            try await userRepository.updateUser(photoURL: url)
        }
        
        Task {
            guard let previousURL = userRepository.user?.photoURL?.absoluteString else { return }
            try await FileUploader.shared.deleteImage(path: previousURL)
        }
    }
}
