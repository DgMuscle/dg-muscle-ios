//
//  SettingV2View.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI

struct SettingV2View: View {
    
    @StateObject var viewModel: SettingV2ViewModel
    @Binding var paths: [NavigationPath]
    
    var body: some View {
        ScrollView {
            if let user = viewModel.user {
                Button {
                    print("Go to Edit Profile screen")
                } label: {
                    HStack {
                        UserBoxView(user: user, descriptionLabel: "Configure Your Profile")
                        Spacer()
                    }
                }
            }
            
            ExerciseListSectionView {
                paths.append(.manageExercise)
            } guideAction: {
                print("guide action")
            } appleWatchAction: {
                print("apple watch action")
            }
            .padding(.top, 40)
            
            
            VStack(spacing: 12) {
                HStack {
                    Button("logout") {
                        print("logout")
                    }
                    Spacer()
                }
                
                HStack {
                    Button("remove account") {
                        print("remove account")
                    }
                    .foregroundStyle(.red)
                    Spacer()
                }
            }
            .padding(.vertical, 60)
            
        }
        .padding()
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    
    let settingViewModel = SettingV2ViewModel(userRepository: UserRepositoryV2Test())
    
    return SettingV2View(viewModel: settingViewModel, paths: .constant([]))
        .preferredColorScheme(.dark)
}
