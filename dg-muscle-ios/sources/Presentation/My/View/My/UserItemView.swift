//
//  UserItemView.swift
//  My
//
//  Created by 신동규 on 5/19/24.
//

import SwiftUI
import Common
import Kingfisher

struct UserItemView: View {
    
    let user: Common.User
    
    var body: some View {
        HStack {
            if let url = user.photoURL {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }
            
            Text(user.displayName ?? "Display Name")
                .foregroundStyle(Color(uiColor: .label))
                .fontWeight(.black)
            
            Spacer()
        }
    }
}
