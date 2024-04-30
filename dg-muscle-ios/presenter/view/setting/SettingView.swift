//
//  SettingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var viewModel: SettingViewModel
    @EnvironmentObject var coordinator: CoordinatorV2
    
    var body: some View {
        List {
            Section {
                VStack {
                    Button {
                        coordinator.main.openWeb(url: "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd")
                    } label: {
                        ListItemView(systemImageName: "a.book.closed",
                                     title: "DgMuscle Introduce",
                                     color: .purple)
                    }
                    
                    Button {
                        coordinator.exercise.manage()
                    } label: {
                        ListItemView(systemImageName: "dumbbell.fill",
                                     title: "Exercise",
                                     description: "Manage your exercise list",
                                     color: .blue)
                    }
                }
            } header: {
                VStack {
                    if let user = viewModel.user {
                        UserBoxView2(user: user, descriptionLabel: "Configure Your Profile")
                            .padding(.bottom)
                    }
                }
            } footer: {
                VStack(spacing: 20) {
                    Button {
                        viewModel.signOut()
                    } label: {
                        ListItemView(systemImageName: "figure.run", title: "LOGOUT", color: .green)
                    }
                    
                    ListItemView(systemImageName: "trash", title: "DELETE ACCOUNT", color: .red)
                }
                .padding(.top, 40)
            }
        }
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let userRepository: UserRepository = UserRepositoryTest()
    let authenticator: AuthenticatorInterface = AuthenticatorTest()
    let viewModel: SettingViewModel = .init(subscribeUserUsecase: .init(userRepository: userRepository),
                                            signOutUsecase: .init(authenticator: authenticator),
                                            deleteAccountUsecase: .init(authenticator: authenticator))
    return SettingView(viewModel: viewModel)
        .preferredColorScheme(.dark)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
