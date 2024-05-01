//
//  DeleteUserProfileImageUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class DeleteUserProfileImageUsecase {
    let userRepository: UserRepository
    let fileUploader: FileUploaderInterface
    
    init(userRepository: UserRepository,
         fileUploader: FileUploaderInterface) {
        self.userRepository = userRepository
        self.fileUploader = fileUploader
    }
    
    func implement() async throws {
        if let url = userRepository.user?.photoURL {
            try? await fileUploader.deleteImage(path: url.absoluteString)
        }
        try await userRepository.updateUser(photoURL: nil)
    }
}
