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
    
    @Published var selectedUserPhoto: PhotosPickerItem?
    @Published var userImage: UIImage?
    private var userImageChanged: Bool = false
    
    @Published var displayName: String = ""
    private var displayNameChanged: Bool = false
    
    @Published var link: URL?
    private var linkChanged: Bool = false
    
    private let getUserUsecase: GetUserUsecase
    private let postBackgroundImageUsecase: PostBackgroundImageUsecase
    private let postDisplayNameUsecase: PostDisplayNameUsecase
    private let postLinkUsecase: PostLinkUsecase
    private let postProfilePhotoUsecase: PostProfilePhotoUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        getUserUsecase = .init(userRepository: userRepository)
        postBackgroundImageUsecase = .init(userRepository: userRepository)
        postDisplayNameUsecase = .init(userRepository: userRepository)
        postLinkUsecase = .init(userRepository: userRepository)
        postProfilePhotoUsecase = .init(userRepository: userRepository)
        
        guard let user = getUserUsecase.implement() else { return }
        
        if let backgroundImageURL = user.backgroundImageURL {
            Task {
                let backgroundImage = try await UIImageGenerator.shared.generateImageFrom(url: backgroundImageURL)
                DispatchQueue.main.async { [weak self] in
                    self?.backgroundImage = backgroundImage
                }
            }
        }
        
        if let userImageUrl = user.photoURL {
            Task {
                let userImage = try await UIImageGenerator.shared.generateImageFrom(url: userImageUrl)
                DispatchQueue.main.async { [weak self] in
                    self?.userImage = userImage
                }
            }
        }
        
        self.displayName = (user.displayName ?? "Display Name")
        self.link = user.link
        
        bind()
    }
    
    @MainActor
    func setLink(_ value: URL?) {
        linkChanged = true
        self.link = value
    }
    
    @MainActor
    func setDisplayName(_ value: String) {
        displayNameChanged = true
        self.displayName = value
    }
    
    private func bind() {
        $selectedBackgroundPhoto
            .dropFirst()
            .sink { [weak self] photo in
                self?.configureBackgroundImage(photo: photo)
            }
            .store(in: &cancellables)
            
        $selectedUserPhoto
            .dropFirst()
            .sink { [weak self] photo in
                self?.configureUserImage(photo: photo)
            }
            .store(in: &cancellables)
    }
    
    private func configureBackgroundImage(photo: PhotosPickerItem?) {
        Task {
            backgroundImageChanged = true
            guard let photo else {
                DispatchQueue.main.async { [weak self] in
                    self?.backgroundImage = nil
                }
                return
            }
            
            guard let data = try await photo.loadTransferable(type: Data.self) else {
                DispatchQueue.main.async { [weak self] in
                    self?.backgroundImage = nil
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.backgroundImage = UIImage(data: data)
            }
        }
    }
    
    private func configureUserImage(photo: PhotosPickerItem?) {
        Task {
            userImageChanged = true
            guard let photo else {
                DispatchQueue.main.async { [weak self] in
                    self?.userImage = nil
                }
                return
            }
            
            guard let data = try await photo.loadTransferable(type: Data.self) else {
                DispatchQueue.main.async { [weak self] in
                    self?.userImage = nil
                }
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.userImage = UIImage(data: data)
            }
        }
    }
}
