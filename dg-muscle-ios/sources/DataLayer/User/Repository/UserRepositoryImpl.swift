//
//  UserRepositoryImpl.swift
//  Data
//
//  Created by Donggyu Shin on 5/14/24.
//

import Combine
import Domain
import Foundation
import FirebaseAuth
import UIKit
import WidgetKit

public final class UserRepositoryImpl: UserRepository {
    public static let shared = UserRepositoryImpl()
    public var user: AnyPublisher<Domain.User?, Never> { $_user.eraseToAnyPublisher() }
    public var isReady: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    @Published var _user: Domain.User? = nil
    @Published var isLogin: Bool = false
    
    private init() {
        bind()
    }
    
    public func signOut() throws {
        try AuthManager().signOut()
    }
    
    public func updateUser(displayName: String?) async throws {
        _user?.displayName = displayName
        try await AuthManager().updateUser(displayName: displayName)
    }
    
    public func updateUser(link: URL?) {
        _user?.link = link
    }
    
    public func updateUser(displayName: String?, photo: UIImage?) async throws {
        _user?.displayName = displayName
        
        if let path = _user?.photoURL?.absoluteString {
            try await FirestoreFileUploader.shared.deleteImage(path: path)
        }
        
        if let photo {
            let path: String = "profilePhoto/\(_user?.uid ?? "")/\(UUID().uuidString).png"
            let url = try await FirestoreFileUploader.shared.uploadImage(path: path, image: photo)
            _user?.photoURL = url
        }
        
        try await AuthManager().updateUser(displayName: _user?.displayName, photoURL: _user?.photoURL)
    }
    
    public func updateUser(backgroundImage: UIImage?) async throws {
        if let path = _user?.backgroundImageURL?.absoluteString {
            try await FirestoreFileUploader.shared.deleteImage(path: path)
        }
        
        if let photo = backgroundImage {
            let path: String = "backgroundImage/\(_user?.uid ?? "")/\(UUID().uuidString).png"
            let url = try await FirestoreFileUploader.shared.uploadImage(path: path, image: photo)
            _user?.backgroundImageURL = url
        }
    }
    
    public func updateUser(photo: UIImage?) async throws {
        if let path = _user?.photoURL?.absoluteString {
            try await FirestoreFileUploader.shared.deleteImage(path: path)
        }
        
        if let photo {
            let path: String = "profilePhoto/\(_user?.uid ?? "")/\(UUID().uuidString).png"
            let url = try await FirestoreFileUploader.shared.uploadImage(path: path, image: photo)
            _user?.photoURL = url
        }
        
        try await AuthManager().updateUser(photoURL: _user?.photoURL)
    }
    
    public func withDrawal() async -> (any Error)? {
        await AuthManager().withDrawal()
    }
    
    public func get() -> Domain.User? {
        _user
    }
    
    public func post(_ heatMapColor: Domain.HeatMapColor) throws {
        _user?.heatMapColor = heatMapColor
        let heatMapColor: HeatMapColor = .init(domain: heatMapColor)
        try FileManagerHelper.shared.save(heatMapColor, toFile: .heatmapColor)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    public func post(fcmToken: String) {
        if _user == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.post(fcmToken: fcmToken)
            }
        } else {
            _user?.fcmToken = fcmToken
        }
    }
    
    private func bind() {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user else {
                self._user = nil
                self.isReady = true
                return
            }
            Task {
                self._user = try? await self.getUserProfileFromUid(uid: user.uid)
                self.isReady = true
            }
        }
        
        $_user
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { user in
                self.isLogin = user != nil
                Task {
                    if let user {
                        try await self.postUserProfileToServer(user: user)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func getUserProfileFromUid(uid: String) async throws -> Domain.User {
        let url = FunctionsURL.user(.getprofilefromuid) + "?uid=\(uid)"
        let data: UserData = try await APIClient.shared.request(url: url)
        return data.domain
    }
    
    private func postUserProfileToServer(user: Domain.User) async throws {
        let url = FunctionsURL.user(.postprofile)
        
        struct Body: Codable {
            let id: String
            let displayName: String
            let photoURL: String?
            let fcmtoken: String?
            let heatmapColor: String
            let backgroundImageURL: String?
            let link: String?
        }
        
        let user: UserData = .init(domain: user)
        
        let body: Body = .init(
            id: user.id,
            displayName: user.displayName ?? "",
            photoURL: user.photoURL,
            fcmtoken: user.fcmToken,
            heatmapColor: user.heatmapColor?.rawValue ?? "green", 
            backgroundImageURL: user.backgroundImageURL,
            link: user.link
        )
        
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: body
        )
    }
}
