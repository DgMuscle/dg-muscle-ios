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
    @State private var offset: CGFloat = 0
    
    private let profileImageSize: CGFloat = 80
    
    var body: some View {
        ZStack {
            if let backgroundURL = friend.backgroundImageURL {
                Rectangle()
                    .fill(.clear)
                    .background(
                        KFImage(backgroundURL)
                            .resizable()
                            .scaledToFill()
                    )
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 16) {
                
                HStack {
                    Spacer()
                    Button("close", systemImage: "xmark") {
                        selectedFriend = nil
                    }
                    .foregroundStyle(Color(uiColor: .label))
                }
                .padding(.horizontal)
                
                Spacer()
                
                if let url = friend.photoURL {
                    KFImage(url)
                        .resizable()
                        .frame(width: profileImageSize, height: profileImageSize)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(uiColor: .tertiarySystemBackground))
                        .frame(width: profileImageSize, height: profileImageSize)
                        .overlay {
                            Image(systemName: "person")
                                .font(.largeTitle)
                        }
                }
                
                Text(friend.displayName ?? friend.id)
                    .fontWeight(.black)
                
                if let link = friend.link {
                    VStack {
                        HStack {
                            Text(link.absoluteString)
                            Image(systemName: "link")
                        }
                        .onTapGesture {
                            URLManager.shared.open(url: link)
                        }
                        Divider()
                            .frame(height: 1)
                    }
                }
                
                GradientButton(action: {
                    print("tap friend history button")
                }, text: "Workout History", backgroundColor: friend.heatMapColor.color)
                .padding(.horizontal)
            }
        }
        .offset(y: offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    
                    let newOffset = gesture.translation.height - 50
                    if newOffset >= 0 {
                        offset = newOffset
                    }
                }
                .onEnded { gesture in
                    if gesture.translation.height > 400 {
                        selectedFriend = nil
                    } else {
                        withAnimation {
                            offset = .zero
                        }
                    }
                }
        )
        
    }
}

#Preview {
    let view = FriendProfileView(
        friend: .init(domain: FRIEND_1),
        selectedFriend: .constant(.init(domain: FRIEND_1))
    )
        .preferredColorScheme(.dark)
    return view
}
