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
    
    public var isAppReady: AnyPublisher<Bool, Never> {
        $isReady.eraseToAnyPublisher()
    }
    
    public var startDeleteAccount: PassthroughSubject<(), Never> = .init()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var _user: Domain.User? = nil
    @Published var isLogin: Bool = false
    @Published public var isReady: Bool = false
    
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
    
    public func updateUser(onlyShowsFavoriteExercises: Bool) {
        _user?.onlyShowsFavoriteExercises = onlyShowsFavoriteExercises
    }
    
    public func updateUser(trainingMode: Domain.TrainingMode) {
        _user?.trainingMode = trainingMode
    }
    
    public func withDrawal() async -> (any Error)? {
        
        if _user?.uid == "taEJh30OpGVsR3FEFN2s67A8FvF3" {
            return DataError.authentication
        }
        
        do {
            let _: DataResponse = try await APIClient.shared.request(
                method: .delete,
                url: FunctionsURL.user(.deleteaccount)
            )
            return await AuthManager().withDrawal()
        } catch {
            return error
        }
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
                self._user = await self.getUserProfileFromUid(uid: user.uid)
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
    
    private func getUserProfileFromUid(uid: String) async -> Domain.User {
        do {
            let url = FunctionsURL.user(.getprofilefromuid) + "?uid=\(uid)"
            let data: UserData = try await APIClient.shared.request(url: url)
            return data.domain
        } catch {
            let user: Domain.User = .init(
                uid: uid,
                backgroundImageURL: nil,
                heatMapColor: .green,
                fcmToken: nil,
                link: nil,
                developer: false,
                onlyShowsFavoriteExercises: false, 
                trainingMode: .mass
            )
            return user
        }
    }
    
    private func postUserProfileToServer(user: Domain.User) async throws {
        let url = FunctionsURL.user(.postprofile)
        let user: UserData = .init(domain: user)
        
        let _: DataResponse = try await APIClient.shared.request(
            method: .post,
            url: url,
            body: user
        )
    }
}
