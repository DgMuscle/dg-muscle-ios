//
//  ProfilePhotoEditViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI
import Combine
import Kingfisher
import PhotosUI

final class ProfilePhotoEditViewModel: ObservableObject {
    @Published var photosPickerItem: PhotosPickerItem?
    @Published var uiimage: UIImage?
    @Published var errorMessage: String?
    @Published var loading: Bool = false
    
    let postUserProfileImageUsecase: PostUserProfileImageUsecase
    let deleteUserProfileImageUsecase: DeleteUserProfileImageUsecase
    let getUserUsecase: GetUserUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(postUserProfileImageUsecase: PostUserProfileImageUsecase,
         deleteUserProfileImageUsecase: DeleteUserProfileImageUsecase,
         getUserUsecase: GetUserUsecase) {
        self.postUserProfileImageUsecase = postUserProfileImageUsecase
        self.deleteUserProfileImageUsecase = deleteUserProfileImageUsecase
        self.getUserUsecase = getUserUsecase
        
        configureProfileImage()
        bind()
    }
    
    func save() {
        Task {
            errorMessage = nil
            guard loading == false else { return }
            guard let uiimage else { return }
            loading = true
            do {
                try await postUserProfileImageUsecase.implement(data: uiimage)
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
    }
    
    func delete() {
        Task {
            errorMessage = nil
            guard loading == false else { return }
            loading = true
            uiimage = nil
            do {
                try await deleteUserProfileImageUsecase.implement()
            } catch {
                errorMessage = error.localizedDescription
            }
            loading = false
        }
    }
    
    private func bind() {
        $photosPickerItem
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.convertPhotoPickerItemToUIImage(item: item)
            }
            .store(in: &cancellables)
    }
    
    
    private func convertPhotoPickerItemToUIImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            uiimage = .init(data: data)
        }
    }
    
    private func configureProfileImage() {
        Task {
            guard let photoURL = getUserUsecase.implement()?.photoURL else { return }
            let uiimage = try await urlStringToUIImage(url: photoURL)
            DispatchQueue.main.async { [weak self] in
                self?.uiimage = uiimage
            }
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
