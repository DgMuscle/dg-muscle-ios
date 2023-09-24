//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userStore = store.user
    
    var body: some View {
        ZStack {
            if userStore.login {
                TabView()
            } else {
                SignInView()
            }
        }
    }
}
