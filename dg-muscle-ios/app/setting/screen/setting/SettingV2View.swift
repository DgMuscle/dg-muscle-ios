//
//  SettingV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SettingV2View: View {
    
    @StateObject var viewModel: SettingV2ViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var isPresentRemoveAccount: Bool = false
    
    var body: some View {
        ScrollView {
            
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            if let user = viewModel.user {
                Button {
                    coordinator.main.profile()
                } label: {
                    HStack {
                        UserBoxView(user: user, descriptionLabel: "Configure Your Profile")
                        Spacer()
                    }
                }
            }
            
            ExerciseListSectionView {
                coordinator.exercise.manage()
            } introduceAction: {
                coordinator.main.openWeb(url: "https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd")
            }
            .padding(.top, 40)
            
            
            VStack(spacing: 12) {
                Button {
                    viewModel.logout()
                } label: {
                    SettingListItemView(systemImageName: "figure.run",
                                        title: "Logout",
                                        color: .green)
                }
                .padding(.bottom, 20)
                
                Button {
                    isPresentRemoveAccount.toggle()
                } label: {
                    SettingListItemView(systemImageName: "trash",
                                        title: "Remove Account",
                                        color: .red)
                }
            }
            .padding(.vertical, 60)
            
        }
        .padding()
        .scrollIndicators(.hidden)
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isPresentRemoveAccount) {
            RemoveAccountView(viewModel: .init(userRepository: viewModel.userRepository,
                                               loading: $viewModel.loading,
                                               errorMessage: $viewModel.errorMessage,
                                               isPresent: $isPresentRemoveAccount))
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    
    let settingViewModel = SettingV2ViewModel(userRepository: UserRepositoryV2Test())
    
    return SettingV2View(viewModel: settingViewModel)
        .preferredColorScheme(.dark)
        .environmentObject(Coordinator(path: .constant(.init())))
}
