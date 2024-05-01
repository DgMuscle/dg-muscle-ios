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
    @State private var isPresentRemoveAccountView: Bool = false
    
    let getUserUsecase: GetUserUsecase
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 20) {
                    Button {
                        coordinator.main.openWeb(url: "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd")
                    } label: {
                        ListItemView(systemImageName: "a.book.closed",
                                     title: "DgMuscle Introduce",
                                     color: .purple)
                    }
                    .buttonStyle(.borderless)
                    
                    Button {
                        coordinator.exercise.manage()
                    } label: {
                        ListItemView(systemImageName: "dumbbell.fill",
                                     title: "Exercise",
                                     description: "Manage your exercise list",
                                     color: .blue)
                    }
                    .buttonStyle(.borderless)
                }
            } header: {
                if let user = viewModel.user {
                    UserBoxView2(user: user, descriptionLabel: "Configure Your Profile")
                        .padding(.bottom)
                        .onTapGesture {
                            coordinator.main.profile()
                        }
                }
            } footer: {
                VStack(spacing: 20) {
                    Button {
                        viewModel.signOut()
                    } label: {
                        ListItemView(systemImageName: "figure.run", title: "LOGOUT", color: .green)
                    }
                    Button {
                        isPresentRemoveAccountView.toggle()
                    } label: {
                        ListItemView(systemImageName: "trash", title: "DELETE ACCOUNT", color: .red)
                    }
                    
                }
                .padding(.top, 40)
            }
        }
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresentRemoveAccountView) {
            RemoveAccountConfirmView(viewModel: .init(getUserUsecase: getUserUsecase)) {
                isPresentRemoveAccountView.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.deleteAccount()
                }
            }
            .presentationDetents([.height(240)])
        }
    }
}

#Preview {
    let userRepository: UserRepository = UserRepositoryTest()
    let authenticator: AuthenticatorInterface = AuthenticatorTest()
    let viewModel: SettingViewModel = .init(subscribeUserUsecase: .init(userRepository: userRepository),
                                            signOutUsecase: .init(authenticator: authenticator),
                                            deleteAccountUsecase: .init(authenticator: authenticator))
    return SettingView(viewModel: viewModel, 
                       getUserUsecase: .init(userRepository: userRepository))
        .preferredColorScheme(.dark)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
