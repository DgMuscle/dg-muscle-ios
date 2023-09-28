//
//  DependencyInjection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI
import Foundation

final class DependencyInjection {
    static let shared = DependencyInjection()
    
    private init () { }
    
    func setting(isShowingProfilePhotoPicker: Binding<Bool>) -> SettingViewDependency {
        SettingViewDependencyImpl(isShowingProfilePhotoPicker: isShowingProfilePhotoPicker)
    }
    
    func photo() -> PhotoPickerViewDependency {
        PhotoPickerViewDependencyImpl()
    }
}

struct PhotoPickerViewDependencyImpl: PhotoPickerViewDependency {
    func saveProfileImage(image: UIImage?) async throws {
        guard let uid = store.user.uid else { throw CustomError.authentication }
        
        if let previousPhotoURLString = store.user.photoURL?.absoluteString, let path = URL(string: previousPhotoURLString)?.lastPathComponent {
            try await FileUploader.shared.deleteImage(path: "profilePhoto/\(uid)/\(path)")
            try await Authenticator().updateUser(displayName: store.user.displayName, photoURL: nil)
        }
        
        if let image {
            let url = try await FileUploader.shared.uploadImage(path: "profilePhoto/\(uid)/\(UUID().uuidString).png", image: image)
            try await Authenticator().updateUser(displayName: store.user.displayName, photoURL: url)
        }
        
        store.user.updateUser()
    }
}

struct SettingViewDependencyImpl: SettingViewDependency {
    
    @Binding var isShowingProfilePhotoPicker: Bool
    
    func tapDisplayName() { }
    
    func tapProfileImage() {
        withAnimation {
            isShowingProfilePhotoPicker.toggle()
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func signOut() throws {
        try Authenticator().signOut()
    }
    
    init(isShowingProfilePhotoPicker: Binding<Bool>) {
        _isShowingProfilePhotoPicker = isShowingProfilePhotoPicker
    }
}
