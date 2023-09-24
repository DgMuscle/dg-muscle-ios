//
//  UserStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import Combine
import SwiftUI
import FirebaseAuth

final class UserStore: ObservableObject {
    static let shared = UserStore()
    
    @Published private(set) var login = true
    @Published private(set) var displayName: String?
    @Published private(set) var photoURL: URL?
    
    private init() {
        Auth.auth().addStateDidChangeListener { _, user in
            withAnimation {
                self.login = user != nil
                self.displayName = user?.displayName
                self.photoURL = user?.photoURL
            }
        }
    }
}
