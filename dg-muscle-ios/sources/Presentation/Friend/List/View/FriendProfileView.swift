//
//  FriendProfileView.swift
//  Friend
//
//  Created by 신동규 on 6/12/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher
import Common

struct FriendProfileView: View {
    
    let friend: Friend
    @Binding var selectedFriend: Friend?
    
    
    var body: some View {
        Text("Friend Profile View")
    }
}

#Preview {
    FriendProfileView(
        friend: .init(domain: USER_DG),
        selectedFriend: .constant(.init(domain: USER_DG))
    )
    .preferredColorScheme(.dark)
}
