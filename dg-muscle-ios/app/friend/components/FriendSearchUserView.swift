//
//  FriendSearchUserView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/26/24.
//

import SwiftUI
import Kingfisher

struct FriendSearchUserView: View {
    
    typealias SearchedUser = FriendsSearchViewModel.SearchedUser
    let user: SearchedUser
    
    let sendRequestAction: (() -> ())?
    
    var body: some View {
        HStack(spacing: 12) {
            if let photoURL = user.user.photoURL {
                KFImage(photoURL)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 60)
            }
            
            if let name = user.user.displayName {
                Text(name).fontWeight(.black)
            } else {
                Text("No DisplayName")
                    .italic()
                    .foregroundStyle(.secondary)
                    .fontWeight(.black)
            }
            
            if user.isMyFriend {
                Image(systemName: "person.circle")
                    .foregroundStyle(.yellow)
            }
            
            Spacer()
            
            if user.isMyFriend == false {
                Button {
                    sendRequestAction?()
                } label: {
                    HStack {
                        Text("send request".capitalized)
                        Image(systemName: "paperplane")
                    }
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(colors: [.blue, .blue.opacity(0.4)], startPoint: .leading, endPoint: .trailing)
                            )
                    )
                }
            }
            
        }
    }
}

#Preview {
    
    let user1: FriendSearchUserView.SearchedUser = .init(user: .init(uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2", displayName: "낙용", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8")),
                                                        isMyFriend: true)
    
    let user2 = FriendSearchUserView.SearchedUser(user: .init(uid: "TtR7J1C8hgOG3fnMdqPQIoDPdVZ2", displayName: "죽겠어요", photoURL: nil),
                                                  isMyFriend: false)
    
    let user3 = FriendSearchUserView.SearchedUser(user: .init(uid: "Asdasdjkahsdjkhdkjhsdkjfdj2d", displayName: nil, photoURL: nil),
                                                  isMyFriend: false)
    
    return VStack {
        FriendSearchUserView(user: user1, sendRequestAction: nil)
        FriendSearchUserView(user: user2, sendRequestAction: nil)
        FriendSearchUserView(user: user3, sendRequestAction: nil)
    }
        .preferredColorScheme(.dark)
}
