//
//  UpdateProfilePhotoViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/17/24.
//

import SwiftUI
import Combine
import Kingfisher
import PhotosUI

final class UpdateProfilePhotoViewModel: ObservableObject {
    @Published var photosPickerItem: PhotosPickerItem?
    @Published var uiimage: UIImage?
    @Published var errorMessage: String?
    @Published var loading: Bool = false
    
    let userRepository: UserRepositoryV2
    let fileUploader: FileUploaderInterface
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepositoryV2,
         fileUploader: FileUploaderInterface) {
        self.userRepository = userRepository
        self.fileUploader = fileUploader
        configureProfileImage()
        bind()
    }
    
    @MainActor
    func save() {
        // Upload Task
        Task {
            guard loading == false else { return }
            loading = true
            do {
                guard let user = userRepository.user else { return }
                guard let uiimage else { return }
                let url = try await fileUploader.uploadImage(path: "profilePhoto/\(user.uid)/\(UUID().uuidString).png", image: uiimage)
                try await userRepository.updateUser(photoURL: url)
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
        
        // Delete Task
        Task {
            guard let previousPhotoURLString = userRepository.user?.photoURL?.absoluteString else { return }
            guard let path = URL(string: previousPhotoURLString)?.lastPathComponent else { return }
            try await fileUploader.deleteImage(path: path)
        }
    }
    
    @MainActor
    func delete() {
        uiimage = nil
        // Delete Task
        Task {
            guard let previousPhotoURLString = userRepository.user?.photoURL?.absoluteString else { return }
            guard let path = URL(string: previousPhotoURLString)?.lastPathComponent else { return }
            try await fileUploader.deleteImage(path: path)
        }
        
        Task {
            try await userRepository.updateUser(photoURL: nil)
        }
    }
    
    private func bind() {
        $photosPickerItem
            .compactMap({ $0 })
            .sink { [weak self] item in
                self?.convertPhotoPickerItemToUIImage(item: item)
            }
            .store(in: &cancellables)
    }
    
    private func convertPhotoPickerItemToUIImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.uiimage = .init(data: data)
            }
        }
    }
    
    private func configureProfileImage() {
        Task {
            guard let photoURL = userRepository.user?.photoURL else { return }
            self.uiimage = try await urlStringToUIImage(url: photoURL)
        }
    }
    
    private func urlStringToUIImage(url: URL) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value.image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}