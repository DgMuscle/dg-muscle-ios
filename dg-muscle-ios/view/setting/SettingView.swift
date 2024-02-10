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
    func tapExercise()
    func tapExerciseList()
    func tapLogout()
    func tapWithdrawal()
    func tapWatchApp()
    func tapGuide()
}

struct SettingView: View {
    let dependency: SettingViewDependency
    @StateObject private var userStore: UserStore = store.user
    private let profileImageSize: CGFloat = 30
    
    var body: some View {
        Form {
            Section("profile") {
                Button {
                    dependency.tapProfileSection()
                } label: {
                    
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
                                .foregroundStyle(Color(uiColor: .label))
                        } else {
                            Text("display name")
                                .italic()
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                        }
                    }
                }
            }
            
            Section("health") {
                Button {
                    dependency.tapExercise()
                } label: {
                    
                    HStack {
                        Image(systemName: "heart").foregroundStyle(.pink)
                        Text("exercise").foregroundStyle(Color(uiColor: .label))
                    }
                }
                
                Button {
                    dependency.tapExerciseList()
                } label: {
                    
                    HStack {
                        Image(systemName: "list.bullet.rectangle.portrait").foregroundStyle(.pink)
                        Text("exercise guide").foregroundStyle(Color(uiColor: .label))
                    }
                }
                
                Button {
                    dependency.tapWatchApp()
                } label: {
                    
                    HStack {
                        Image(systemName: "applewatch").foregroundStyle(.pink)
                        Text("watch workout app").foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            
            Section("guide") {
                Button {
                    dependency.tapGuide()
                } label: {
                    HStack {
                        Image(systemName: "book").foregroundStyle(.purple)
                        Text("guide").foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            
            Section {
                Button {
                    dependency.tapLogout()
                } label: {
                    Text("logout")
                        .foregroundStyle(Color(uiColor: .label))
                        .font(.footnote)
                        .italic()
                }
                
                Button {
                    dependency.tapWithdrawal()
                } label: {
                    Text("remove account")
                        .foregroundStyle(.red)
                        .font(.footnote)
                        .italic()
                }
            } footer: {
                Text("account")
            }
        }
    }
}

#Preview {
    class DP: SettingViewDependency {
        func tapProfileSection() { }
        func tapExercise() { }
        func tapExerciseList() { }
        func tapLogout() { }
        func tapWithdrawal() { }
        func tapWatchApp() { }
        func tapGuide() { }
    }
    
    return SettingView(dependency: DP()).preferredColorScheme(.dark)
}
