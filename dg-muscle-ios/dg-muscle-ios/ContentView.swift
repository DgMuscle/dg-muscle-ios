//
//  ContentView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var login = false
    
    init() {
        Auth.auth().addStateDidChangeListener { [self] _, user in
            withAnimation {
                self.login = user != nil
            }
        }
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
