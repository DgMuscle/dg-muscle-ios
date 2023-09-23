//
//  UserStore.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/23.
//

import Combine
import FirebaseAuth

final class UserStore {
    static let shared = UserStore()
    
    @Published private(set) var login = false
    @Published private(set) var displayName: String?
    
    private init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.login = user != nil
            self.displayName = user?.displayName
        }
    }
}
