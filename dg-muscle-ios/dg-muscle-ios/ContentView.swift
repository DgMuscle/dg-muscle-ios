//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var login = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        store.user.$login.sink { [self] login in
            self.login = login
        }.store(in: &cancellables)
    }
    
    var body: some View {
        ZStack {
            if login {
                SignInView()
            } else {
                Text("logged in")
            }
        }
    }
}
