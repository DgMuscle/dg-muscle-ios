//
//  ProfileEditView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI
import Kingfisher

struct ProfileEditView: View {
    @EnvironmentObject var coordinator: CoordinatorV2
    @StateObject var viewModel: ProfileEditViewModel
    let healthRepository: HealthRepositoryDomain
    
    @State private var presentEditDisplayNameView: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if let user = viewModel.user {
                        ProfileUserSimpleView(user: user) {
                            coordinator.main.profilePhoto()
                        } tapDisplayName: {
                            presentEditDisplayNameView.toggle()
                        }
                    }
                    
                    HealthInfoView(viewModel: .init(getHealthInfoUsecase: .init(healthRepository: healthRepository)))
                        .padding(.top)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            
            if presentEditDisplayNameView {
                DisplayNameEditView(displayName: viewModel.user?.displayName ?? "") { name in
                    viewModel.updateName(name: name)
                    presentEditDisplayNameView = false
                } tapBackground: {
                    presentEditDisplayNameView = false
                }
            }
        }
        .animation(.default, value: presentEditDisplayNameView)
        .navigationTitle("Profile")
    }
    
    private func tapBackground() {
        presentEditDisplayNameView = false
    }
}

#Preview {
    let userRepository: UserRepository = UserRepositoryTest()
    let healthRepository: HealthRepositoryDomain = HealthRepositoryTest2()
    let viewModel: ProfileEditViewModel = .init(
        postUserDisplayNameUsecase: .init(userRepository: userRepository),
        subscribeUserUsecase: .init(userRepository: userRepository)
    )
    return ProfileEditView(viewModel: viewModel,
                    healthRepository: healthRepository)
    .preferredColorScheme(.dark)
    .environmentObject(CoordinatorV2(path: .constant(.init())))
}
