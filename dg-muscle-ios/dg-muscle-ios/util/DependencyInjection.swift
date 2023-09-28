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
    
    func setting(isShowingProfilePhotoPicker: Binding<Bool>, isShowingDisplayName: Binding<Bool>) -> SettingViewDependency {
        SettingViewDependencyImpl(isShowingProfilePhotoPicker: isShowingProfilePhotoPicker, isShowingDisplayName: isShowingDisplayName)
    }
    
    func profilePhotoPicker() -> PhotoPickerViewDependency {
        ProfilePhotoPickerDependencyImpl()
    }
    
    func displayNameTextInput() -> SimpleTextInputDependency {
        DisplayNameTextInputDependency()
    }
}

struct DisplayNameTextInputDependency: SimpleTextInputDependency {
    func save(text: String) async throws {
        try await Authenticator().updateUser(displayName: text.isEmpty ? nil : text, photoURL: store.user.photoURL)
    }
}

struct ProfilePhotoPickerDependencyImpl: PhotoPickerViewDependency {
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
    @Binding var isShowingDisplayName: Bool
    
    func tapDisplayName() {
        withAnimation {
            isShowingDisplayName.toggle()
        }
    }
    
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
    
    init(
        isShowingProfilePhotoPicker: Binding<Bool>,
        isShowingDisplayName: Binding<Bool>
    ) {
        _isShowingProfilePhotoPicker = isShowingProfilePhotoPicker
        _isShowingDisplayName = isShowingDisplayName
    }
}
