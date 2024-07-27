//
//  FriendListItemView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import MockData
import Kingfisher

struct FriendListItemView: View {
    
    let friend: Friend
    private let imageSize: CGFloat = 50
    
    var body: some View {
        HStack(spacing: 20) {
            if let profilePhotoURL = friend.photoURL {
                KFImage(profilePhotoURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Text(friend.displayName ?? "Display Name")
                .foregroundStyle(Color(uiColor: friend.displayName == nil ? .secondaryLabel : .label))
        }
    }
}

#Preview {
    List {
        FriendListItemView(friend: .init(domain: USER_DG))
            .preferredColorScheme(.dark)
    }
}
