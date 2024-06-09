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
import SwiftUI

final class MyProfileViewModel: ObservableObject {
    @Published var color: Color
    @Published var displayName: String
    @Published var profilePhoto: UIImage?
    @Published var backgroundImage: UIImage?
    @Published var status: Common.StatusView.Status?
    
    private let user: Common.User
    private let postDisplayNameUsecase: PostDisplayNameUsecase
    private let postPhotoURLUsecase: PostPhotoURLUsecase
    private let postBackgroundImageUsecase: PostBackgroundImageUsecase
    private let getUserUsecase: GetUserUsecase
    private let signOutUsecase: SignOutUsecase
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        postDisplayNameUsecase = .init(userRepository: userRepository)
        postPhotoURLUsecase = .init(userRepository: userRepository)
        postBackgroundImageUsecase = .init(userRepository: userRepository)
        getUserUsecase = .init(userRepository: userRepository)
        signOutUsecase = .init(userRepository: userRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        
        if let userDomain = getUserUsecase.implement() {
            self.user = .init(domain: userDomain)
            self.displayName = userDomain.displayName ?? ""
        } else {
            self.user = .init()
            self.displayName = ""
            try? signOutUsecase.implement()
        }
        
        let domainColor: Domain.HeatMapColor = getHeatMapColorUsecase.implement()
        let heatMapColor: Common.HeatMapColor = .init(domain: domainColor)
        self.color = heatMapColor.color
        
        if let url = user.photoURL {
            Task { @MainActor in
                let uiimage = try await Common.UIImageGenerator.shared.generateImageFrom(url: url)
                self.profilePhoto = uiimage
            }
        }
        
        if let url = user.backgroundImageURL {
            Task { @MainActor in
                let uiimage = try await Common.UIImageGenerator.shared.generateImageFrom(url: url)
                self.backgroundImage = uiimage
            }
        }
    }
    
    private var saveTask: Task<(), Never>?
    @MainActor
    func save() {
        guard saveTask == nil else { return }
        saveTask = Task {
            do {
                status = .loading
                
                async let displayNameTask: () = postDisplayNameUsecase.implement(displayName: displayName)
                async let photoTask: () = postPhotoURLUsecase.implement(photo: profilePhoto)
                async let backgroundImageTask: () = postBackgroundImageUsecase.implement(backgroundImage: backgroundImage)
                
                try await displayNameTask
                try await photoTask
                try await backgroundImageTask

                status = .success("Done")
            } catch {
                status = .error(error.localizedDescription)
            }
            saveTask = nil
        }
    }
}
