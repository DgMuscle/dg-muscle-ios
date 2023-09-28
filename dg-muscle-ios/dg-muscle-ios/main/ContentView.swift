//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingProfilePhotoPicker = false
    
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                TabView(settingViewDependency: DependencyInjection.shared.setting(isShowingProfilePhotoPicker: $isShowingProfilePhotoPicker))
                
                if isShowingProfilePhotoPicker {
                    PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingProfilePhotoPicker, dependency: DependencyInjection.shared.photo())
                }
            } else {
                SignInView()
            }
        }
    }
}
