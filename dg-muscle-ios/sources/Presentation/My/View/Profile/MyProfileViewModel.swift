//
//  MyProfileViewModel.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import Combine
import Domain
import Common
import UIKit

final class MyProfileViewModel: ObservableObject {
    @Published var displayName: String
    @Published var profilePhoto: UIImage?
    @Published var loading: Bool = false
    @Published var status: Common.StatusView.Status?
    
    private let user: Common.User
    private let postDisplayNameUsecase: PostDisplayNameUsecase
    private let postPhotoURLUsecase: PostPhotoURLUsecase
    private let getUserUsecase: GetUserUsecase
    private let signOutUsecase: SignOutUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        postDisplayNameUsecase = .init(userRepository: userRepository)
        postPhotoURLUsecase = .init(userRepository: userRepository)
        getUserUsecase = .init(userRepository: userRepository)
        signOutUsecase = .init(userRepository: userRepository)
        
        if let userDomain = getUserUsecase.implement() {
            self.user = .init(domain: userDomain)
            self.displayName = userDomain.displayName ?? ""
        } else {
            self.user = .init()
            self.displayName = ""
            try? signOutUsecase.implement()
        }
    }
    
    private var saveTask: Task<(), Never>?
    func save() {
        guard saveTask == nil else { return }
        saveTask = Task {
            do {
                loading = true
                status = nil
                try await postDisplayNameUsecase.implement(displayName: displayName)
                try await postPhotoURLUsecase.implement(photo: profilePhoto)
                status = .success("Done")
            } catch {
                status = .error(error.localizedDescription)
            }
            saveTask = nil
            loading = false
        }
    }
}
