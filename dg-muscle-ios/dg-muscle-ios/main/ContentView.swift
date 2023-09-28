//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingPhotoPickerView = false
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                ZStack {
                    TabView(settingViewDependency: DependencyInjection.shared.setting(isShowingPhotoPickerView: $isShowingPhotoPickerView))
                    
                    if isShowingPhotoPickerView {
                        PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingPhotoPickerView, dependency: DependencyInjection.shared.photo())
                    }
                }
            } else {
                SignInView()
            }
        }
    }
}
