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

final class MyProfileEditViewModel: ObservableObject {
    
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var image: UIImage?
    
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
    }
}
