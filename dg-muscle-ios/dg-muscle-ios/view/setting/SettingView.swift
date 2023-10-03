//
//  SettingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI
import Kingfisher

protocol SettingViewDependency {
    func tapProfileSection()
}

struct SettingView: View {
    let dependency: SettingViewDependency
    @StateObject private var userStore: UserStore = store.user
    private let profileImageSize: CGFloat = 30
    
    var body: some View {
        Form {
            
            Section("profile") {
                HStack {
                    KFImage(userStore.photoURL)
                        .placeholder {
                            Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                        }
                        .resizable()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .scaledToFit()
                        .clipShape(.circle)
                    
                    if let displayName = userStore.displayName {
                        Text(displayName)
                    } else {
                        Text("display name")
                            .italic()
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                }
            }
            .onTapGesture {
                dependency.tapProfileSection()
            }
        }
    }
}
