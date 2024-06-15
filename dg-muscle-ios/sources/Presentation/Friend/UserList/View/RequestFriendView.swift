//
//  RequestFriendView.swift
//  Friend
//
//  Created by 신동규 on 6/2/24.
//

import SwiftUI
import Common
import MockData
import Kingfisher

struct RequestFriendView: View {
    
    let user: Common.User
    let request: ((_ userId: String) -> ())?
    
    private let photoSize: CGFloat = 60
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                if let photoURL = user.photoURL {
                    KFImage(photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: photoSize, height: photoSize)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading) {
                    Text(user.displayName ?? user.uid)
                        .fontWeight(.heavy)
                    
                    Text("'I want to be your friend. Let's share our workout record!'")
                }
            }
            
            Common.GradientButton(action: {
                request?(user.uid)
            }, text: "SEND MESSAGE", backgroundColor: .blue)
            .overlay {
                HStack {
                    Spacer()
                    Image(systemName: "paperplane").padding(.trailing, 20)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    return RequestFriendView(user: .init(domain: USER_DG), request: nil)
        .preferredColorScheme(.dark)
}
