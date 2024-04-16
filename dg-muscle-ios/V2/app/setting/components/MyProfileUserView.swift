//
//  MyProfileUserView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/16/24.
//

import SwiftUI
import Kingfisher

struct MyProfileUserView: View {
    var user: DGUser
    
    private let profileImageSize: CGFloat = 60
    let tapPhoto: (() -> ())?
    let tapDisplayName: (() -> ())?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    tapPhoto?()
                } label: {
                    KFImage(user.photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .clipShape(Circle())
                }
                .padding(.trailing)
                
                Button {
                    tapDisplayName?()
                } label: {
                    if let displayName = user.displayName {
                        Text(displayName).fontWeight(.bold)
                    } else {
                        Text("Display Name")
                    }
                }
                .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
            }
        }
    }
}

#Preview {
    let user = UserRepositoryV2Test().user!
    return MyProfileUserView(user: user,
                             tapPhoto: nil,
                             tapDisplayName: nil)
        .preferredColorScheme(.dark)
}
