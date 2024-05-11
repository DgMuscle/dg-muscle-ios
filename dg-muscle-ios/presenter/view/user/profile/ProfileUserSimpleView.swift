//
//  ProfileUserSimpleView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI
import Kingfisher

struct ProfileUserSimpleView: View {
    
    let user: UserV
    let tapPhoto: (() -> ())?
    let tapDisplayName: (() -> ())?
    
    @State private var isAnimating: Bool = false
    private let profileImageSize: CGFloat = 60
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    tapPhoto?()
                } label: {
                    KFImage(user.photoURL)
                        .placeholder {
                            Circle()
                                .fill(
                                    LinearGradient(colors: [
                                        .secondary,
                                        Color(uiColor: .secondarySystemGroupedBackground)
                                    ],
                                                   startPoint: isAnimating ? .bottomLeading : .topLeading,
                                                   endPoint: isAnimating ? .topTrailing : .bottomTrailing)
                                )
                                .onAppear {
                                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                                        isAnimating = true
                                    }
                                }
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .clipShape(Circle())
                    
                }
                .padding(.trailing)
                
                Button {
                    tapDisplayName?()
                } label: {
                    if let displayName = user.displayName, displayName.isEmpty == false {
                        Text(displayName).fontWeight(.bold)
                    } else {
                        Text("Display Name").foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
            }
        }
    }
}
