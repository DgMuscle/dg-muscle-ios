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
    let fileUploader: FileUploaderInterface
    
    init(userRepository: UserRepository,
         fileUploader: FileUploaderInterface) {
        self.userRepository = userRepository
        self.fileUploader = fileUploader
    }
    
    func implement(data: UIImage) async throws {
        guard let user = userRepository.user else { return }
        let path = "profilePhoto/\(user.uid)/\(UUID().uuidString).png"
        let url = try await fileUploader.uploadImage(path: path, image: data)
        try await userRepository.updateUser(photoURL: url)
        
        Task {
            guard let previousURL = userRepository.user?.photoURL?.absoluteString else { return }
            try await fileUploader.deleteImage(path: previousURL)
        }
    }
}
