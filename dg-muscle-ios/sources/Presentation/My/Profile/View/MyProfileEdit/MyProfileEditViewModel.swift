//
//  MyProfileEditViewModel.swift
//  My
//
//  Created by 신동규 on 8/3/24.
//

import Combine
import Domain
import SwiftUI
import PhotosUI
import Common

final class MyProfileEditViewModel: ObservableObject {
    
    @Published var selectedBackgroundPhoto: PhotosPickerItem?
    @Published var backgroundImage: UIImage?
    private var backgroundImageChanged: Bool = false
    
    private let getUserUsecase: GetUserUsecase
    private let postBackgroundImageUsecase: PostBackgroundImageUsecase
    private let postDisplayNameUsecase: PostDisplayNameUsecase
    private let postLinkUsecase: PostLinkUsecase
    private let postProfilePhotoUsecase: PostProfilePhotoUsecase
    
    init(userRepository: UserRepository) {
        getUserUsecase = .init(userRepository: userRepository)
        postBackgroundImageUsecase = .init(userRepository: userRepository)
        postDisplayNameUsecase = .init(userRepository: userRepository)
        postLinkUsecase = .init(userRepository: userRepository)
        postProfilePhotoUsecase = .init(userRepository: userRepository)
        
        guard let user = getUserUsecase.implement() else { return }
        
        if let backgroundImageURL = user.backgroundImageURL {
            Task {
                let backgroundImage =  try await UIImageGenerator.shared.generateImageFrom(url: backgroundImageURL)
                self.backgroundImage = backgroundImage
            }
        }
    }
}
