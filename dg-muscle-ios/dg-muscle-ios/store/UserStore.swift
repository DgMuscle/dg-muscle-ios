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
    @Published private(set) var uid: String?
    @Published private(set) var displayName: String?
    @Published private(set) var photoURL: URL?
    @Published private(set) var photoUiImage: UIImage?
    @Published private(set) var profile: Profile?
    
    var recentProfileSpec: Profile.Spec? {
        profile?.specs.sorted(by: { $0.createdAt > $1.createdAt }).first
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private init() {
        Auth.auth().addStateDidChangeListener { _, user in
            withAnimation {
                self.set(user: user)
            }
        }
        
        bind()
        setUserCache()
    }
    
    func updateUser() {
        set(user: Auth.auth().currentUser)
    }
    
    func set(displayName: String?, profile: Profile?) {
        self.displayName = displayName
        self.profile = profile
    }
    
    private func set(user: User?) {
        
        Task {
            if let user {
                let userCache = UserCache(displayName: user.displayName, photoUrl: user.photoURL?.absoluteString)
                try FileManagerHelper.save(userCache, toFile: .user)
            } else {
                try FileManagerHelper.File.allCases.forEach({
                    try FileManagerHelper.delete(withName: $0)
                })
            }
        }
        
        DispatchQueue.main.async {
            self.login = user != nil
            self.displayName = user?.displayName
            self.photoURL = user?.photoURL
            self.uid = user?.uid
            
            if self.uid != nil {
                store.history.updateHistories()
                store.exercise.updateExercises()
                Task {
                    self.profile = try await UserRepository.shared.getProfile()
                }
            }
        }
    }
    
    private func bind() {
        $photoURL
            .sink { url in
                if let url {
                    Task {
                        let uiImage = await self.uiImage(from: url)
                        DispatchQueue.main.async {
                            self.photoUiImage = uiImage
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.photoUiImage = nil
                    }
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
    
    private func setUserCache() {
        do {
            if let userCache: UserCache = try? FileManagerHelper.load(UserCache.self, fromFile: .user) {
                DispatchQueue.main.async {
                    self.displayName = userCache.displayName
                    self.photoURL = URL(string: userCache.photoUrl ?? "")
                }
            }
        }
    }
}
