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
            
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.clear)
                .strokeBorder(.white.opacity(0.8), lineWidth: 1)
                .frame(width: imageSize, height: imageSize)
                .background {
                    if let profilePhotoURL = friend.photoURL {
                        KFImage(profilePhotoURL)
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray)
                            
                            Image(systemName: "person")
                                .foregroundStyle(.white)
                        }
                    }
                }
            
            Text((friend.displayName?.isEmpty == false) ? friend.displayName! : friend.uid)
                .foregroundStyle(Color(uiColor: (friend.displayName?.isEmpty == false) ? .label : .secondaryLabel))
        }
    }
}

#Preview {
    List {
        FriendListItemView(friend: .init(domain: USER_DG))
            .preferredColorScheme(.dark)
    }
}
