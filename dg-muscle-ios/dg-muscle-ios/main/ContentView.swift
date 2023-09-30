//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var paths: [NavigationPath] = []
    
    @State var isShowingProfilePhotoPicker = false
    @State var isShowingDisplayName = false
    @State var isPresentedWithDrawalConfirm = false
    @State var isShowingErrorView = false

    @State var error: Error?
    
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if let uid = userStore.uid {
                NavigationStack(path: $paths) {
                    TabView(
                        uid: uid,
                        settingViewDependency: DependencyInjection.shared.setting(
                            isShowingProfilePhotoPicker: $isShowingProfilePhotoPicker,
                            isShowingDisplayName: $isShowingDisplayName,
                            isPresentedWithDrawalConfirm: $isPresentedWithDrawalConfirm),
                        exerciseDiaryDependency: DependencyInjection.shared.exerciseDiary(paths: $paths)
                    )
                    .navigationDestination(for: NavigationPath.self) { path in
                        switch path {
                        case .historyForm:
                            HistoryFormView(
                                dependency:
                                    DependencyInjection.shared.historyForm(isShowingErrorView: $isShowingErrorView, error: $error, paths: $paths),
                                records: [],
                                saveButtonDisabled: true
                            )
                        case .recordForm:
                            RecordFormView(dependency: DependencyInjection.shared.recordForm(paths: $paths))
                        }
                    }
                }
                .sheet(isPresented: $isPresentedWithDrawalConfirm, content: {
                    WithdrawalConfirmView(
                        isPresented: $isPresentedWithDrawalConfirm,
                        dependency: DependencyInjection.shared.withdrawalConfirm(error: $error, isShowingErrorView: $isShowingErrorView))
                })
                
                if isShowingProfilePhotoPicker {
                    PhotoPickerView(uiImage: userStore.photoUiImage, isShowing: $isShowingProfilePhotoPicker, dependency: DependencyInjection.shared.profilePhotoPicker())
                }
                
                if isShowingDisplayName {
                    SimpleTextInputView(text: store.user.displayName ?? "", isShowing: $isShowingDisplayName, placeholder: "display name", dependency: DependencyInjection.shared.displayNameTextInput())
                }
                
            } else {
                SignInView()
            }
            
            if isShowingErrorView {
                ErrorView(message: error?.localizedDescription ?? "unknown error", isShowing: $isShowingErrorView)
            }
        }
    }
}

extension ContentView {
    enum NavigationPath {
        case historyForm
        case recordForm
    }
}
