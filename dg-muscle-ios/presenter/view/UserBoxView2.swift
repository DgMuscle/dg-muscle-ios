//
//  UserBoxView2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import SwiftUI
import Kingfisher

struct UserBoxView2: View {
    @State private var isAnimating = false
    
    let user: UserV
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
    
    let userRepository: UserRepository = UserRepositoryTest()
    let userDomain = userRepository.user!
    let userV = UserV(from: userDomain)
    let description = "go to setting".capitalized
    
    return UserBoxView2(user: userV, descriptionLabel: description).preferredColorScheme(.dark)
}
