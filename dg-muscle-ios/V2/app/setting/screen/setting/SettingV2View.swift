//
//  SettingV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SettingV2View: View {
    
    @StateObject var viewModel: SettingV2ViewModel
    @Binding var paths: NavigationPath
    
    var body: some View {
        ScrollView {
            if let user = viewModel.user {
                Button {
                    paths.append(MainNavigation(name: .profile))
                } label: {
                    HStack {
                        UserBoxView(user: user, descriptionLabel: "Configure Your Profile")
                        Spacer()
                    }
                }
            }
            
            ExerciseListSectionView {
                paths.append(ExerciseNavigation(name: .manage))
            } guideAction: {
                print("guide action")
            } appleWatchAction: {
                print("apple watch action")
            }
            .padding(.top, 40)
            
            
            VStack(spacing: 12) {
                Button {
                    print("logout")
                } label: {
                    SettingListItemView(systemImageName: "figure.run",
                                        title: "Logout",
                                        color: .green)
                }
                .padding(.bottom, 20)
                
                Button {
                    print("remove Account")
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
    }
}

#Preview {
    
    let settingViewModel = SettingV2ViewModel(userRepository: UserRepositoryV2Test())
    
    return SettingV2View(viewModel: settingViewModel, paths: .constant(.init()))
        .preferredColorScheme(.dark)
}
