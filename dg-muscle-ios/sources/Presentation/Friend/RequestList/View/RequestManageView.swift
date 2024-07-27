//
//  RequestManageView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import Common
import MockData

struct RequestManageView: View {
    
    let request: FriendRequest
    let accept: ((FriendRequest) -> ())?
    let refuse: ((FriendRequest) -> ())?
    let color: Color
    
    init(request: FriendRequest, 
         accept: ((FriendRequest) -> ())?,
         refuse: ((FriendRequest) -> ())?,
         color: Color
    ) {
        self.request = request
        self.accept = accept
        self.refuse = refuse
        self.color = color
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(request.user.displayName ?? request.user.uid).foregroundStyle(color) +
                Text(" wants to be a friend")
            }
            .fontWeight(.bold)
            
            Divider()
            
            Common.GradientButton(action: {
                accept?(request)
            }, text: "ACCEPT", backgroundColor: .blue)
            
            Common.GradientButton(action: {
                refuse?(request)
            }, text: "REFUSE", backgroundColor: .pink)
        }
        .padding(.horizontal)
    }
}

#Preview {
    RequestManageView(
        request: .init(user: .init(domain: USERS[4]), createdAt: Date()),
        accept: nil,
        refuse: nil,
        color: .purple
    )
    .preferredColorScheme(.dark)
}
