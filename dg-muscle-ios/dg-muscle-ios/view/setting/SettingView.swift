//
//  SettingView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import SwiftUI
import Kingfisher

protocol SettingViewDependency {
    var tapProfile: (() -> ())? { get }
    var error: ((Error) -> ())? { get }
    
    func signOut() throws
}

struct SettingView: View {
    let dependency: SettingViewDependency
    
    @StateObject private var userStore: UserStore = store.user
    private let profileImageSize: CGFloat = 30
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dependency.tapProfile?()
            } label: {
                HStack {
                    KFImage(userStore.photoURL)
                        .placeholder {
                            Circle().fill(Color(uiColor: .secondarySystemBackground).gradient)
                        }
                        .clipShape(.circle)
                        .frame(width: profileImageSize, height: profileImageSize)
                    
                    Text(userStore.displayName ?? "display name")
                        .foregroundStyle(userStore.displayName == nil ? Color(uiColor: .secondaryLabel) : Color(uiColor: .label))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemBackground).gradient)
                        .shadow(radius: 0.1)
                }
                
            }
            
            Button("sign out") {
                do {
                    try dependency.signOut()
                } catch {
                    dependency.error?(error)
                }
            }
            .padding(.top, 20)
            .foregroundStyle(.red)
            
            Spacer().frame(maxWidth: .infinity)
        }
        .padding()
    }
}
