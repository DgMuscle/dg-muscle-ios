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
    
    @Published var loading: Bool = false
    @Published var snackbar: String?
    
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
    func done() async {
        loading = true
        do {
            async let postBackgroundImage: Void = {
                if backgroundImageChanged {
                    try await postBackgroundImageUsecase.implement(backgroundImage: backgroundImage)
                }
            }()
            
            async let postProfilePhoto: Void = {
                if userImageChanged {
                    try await postProfilePhotoUsecase.implement(photo: userImage)
                }
            }()
            
            async let postDisplayName: Void = {
                if displayNameChanged {
                    try await postDisplayNameUsecase.implement(displayName: displayName.isEmpty ? nil : displayName)
                }
            }()
            
            let postLink: Void = {
                if linkChanged {
                    postLinkUsecase.implement(link: link)
                }
            }()
            
            // 병렬로 시작된 모든 작업이 완료될 때까지 기다립니다.
            try await postBackgroundImage
            try await postProfilePhoto
            try await postDisplayName
            postLink // 이 부분은 비동기가 아니므로 try await가 필요 없습니다.

        } catch {
            snackbar = error.localizedDescription
        }
        loading = false
    }
    
    @MainActor
    func deleteUserPhoto() {
        userImage = nil
        userImageChanged = true
    }
    
    @MainActor
    func deleteBackgroundImage() {
        backgroundImage = nil
        backgroundImageChanged = true
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
