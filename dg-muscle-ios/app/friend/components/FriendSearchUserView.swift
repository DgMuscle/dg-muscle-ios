//
//  FriendSearchUserView.swift
//  dg-muscle-ios
//
//  Created by Donggyu Shin on 4/26/24.
//

import SwiftUI

struct FriendSearchUserView: View {
    
    typealias SearchedUser = FriendsSearchViewModel.SearchedUser
    var user: SearchedUser
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    
    let user1: FriendSearchUserView.SearchedUser = .init(user: .init(uid: "56mGcK9Nm5cVcUk8vxW5h9jIQcA2", displayName: "낙용", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2F56mGcK9Nm5cVcUk8vxW5h9jIQcA2%2FFDED5B8E-229B-4EAE-BEF8-912E5C41D7D6.png?alt=media&token=f74e7d94-c050-461c-98bd-c2e8ded5f9c8")),
                                                        isMyFriend: true)
    
    let user2 = FriendSearchUserView.SearchedUser(user: .init(uid: "TtR7J1C8hgOG3fnMdqPQIoDPdVZ2", displayName: "죽겠어요", photoURL: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/dg-muscle.appspot.com/o/profilePhoto%2FTtR7J1C8hgOG3fnMdqPQIoDPdVZ2%2F75A1245A-B92F-4839-A09A-30FFE7E9FA7D.png?alt=media&token=0dfd0613-6b38-4b43-8887-9af3b0b1140a")),
                                                  isMyFriend: false)
    
    return VStack {
        FriendSearchUserView(user: user1)
        FriendSearchUserView(user: user2)
    }
        .preferredColorScheme(.dark)
}
