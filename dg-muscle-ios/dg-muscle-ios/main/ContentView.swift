//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userStore = store.user
    
    let settingViewInjection: SettingViewInjection = .init()

    var body: some View {
        ZStack {
            if userStore.login {
                TabView(settingViewDependency: settingViewInjection)
            } else {
                SignInView()
            }
        }
    }
}

struct SettingViewInjection: SettingViewDependency {
    var tapDisplayName: (() -> ())?
    
    var tapProfileImage: (() -> ())?
    
    var error: ((Error) -> ())?
    
    func signOut() throws {
        try Authenticator().signOut()
    }
}
