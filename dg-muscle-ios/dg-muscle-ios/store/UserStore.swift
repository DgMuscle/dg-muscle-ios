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
    @Published private(set) var photoUiImage: UIImage?
    
    private var cancellables: Set<AnyCancellable> = []
    private init() {
        Auth.auth().addStateDidChangeListener { _, user in
            withAnimation {
                self.login = user != nil
                self.displayName = user?.displayName
                self.photoURL = user?.photoURL
            }
        }
        
        bind()
    }
    
    private func bind() {
        $photoURL
            .sink { url in
                if let url {
                    Task {
                        let uiImage = await self.uiImage(from: url)
                        self.photoUiImage = uiImage
                    }
                } else {
                    self.photoUiImage = nil 
                }
            }
            .store(in: &cancellables)
    }
    
    private func uiImage(from url: URL) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return continuation.resume(returning: nil) }
                continuation.resume(returning: UIImage(data: data))
            }
        }
    }
}
