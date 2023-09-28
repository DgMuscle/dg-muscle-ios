//
//  DependencyInjection.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/28.
//

import SwiftUI

final class DependencyInjection {
    static let shared = DependencyInjection()
    
    private init () { }
    
    func setting(isShowingPhotoPickerView: Binding<Bool>) -> SettingViewDependency {
        SettingViewDependencyImpl(isShowingPhotoPickerView: isShowingPhotoPickerView)
    }
    
    func photo() -> PhotoPickerViewDependency {
        PhotoPickerViewDependencyImpl()
    }
}

struct PhotoPickerViewDependencyImpl: PhotoPickerViewDependency {
    func savePhoto(image: UIImage?) {
        print("save photo")
    }
}

struct SettingViewDependencyImpl: SettingViewDependency {
    
    @Binding var isShowingPhotoPickerView: Bool
    
    func tapDisplayName() { }
    
    func tapProfileImage() {
        withAnimation {
            isShowingPhotoPickerView.toggle()
        }
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func signOut() throws {
        try Authenticator().signOut()
    }
    
    init(isShowingPhotoPickerView: Binding<Bool>) {
        _isShowingPhotoPickerView = isShowingPhotoPickerView
    }
}
