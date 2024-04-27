//
//  UserBoxView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/13/24.
//

import SwiftUI
import Kingfisher

struct UserBoxView: View {
    
    var user: DGUser
    @State private var isAnimating = false
    
    let descriptionLabel: String
    
    private let circleSize: CGFloat = 60
    
    var body: some View {
        HStack {
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
                .clipShape(.circle)
            .frame(width: circleSize, height: circleSize)
            
            VStack(alignment: .leading) {
                if let displayName = user.displayName, displayName.isEmpty == false {
                    Text(displayName).fontWeight(.heavy)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                HStack {
                    Text(descriptionLabel).fontWeight(.heavy)
                        .foregroundStyle(
                        LinearGradient(colors: [
                            .secondary,
                            .primary,
                        ],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                        )
                    Image(systemName: "gear").fontWeight(.heavy)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
        }
    }
}

#Preview {
    if let user = UserRepositoryV2Test().user {
        return UserBoxView(user: user,
                           descriptionLabel: "Go to setting")
        .preferredColorScheme(.dark)
    } else {
        return Text("No user")
    }
}
