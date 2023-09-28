//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingPhotoPickerView = false
    @State var selectedTab: TabItemsView.Tab = .temp
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                if isShowingPhotoPickerView {
                    PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingPhotoPickerView, dependency: DependencyInjection.shared.photo())
                } else {
                    TabView(selectedTab: $selectedTab, settingViewDependency: DependencyInjection.shared.setting(isShowingPhotoPickerView: $isShowingPhotoPickerView))
                }
            } else {
                SignInView()
            }
        }
    }
}
