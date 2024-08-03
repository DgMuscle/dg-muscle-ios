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
    
    @State private var viewOffset: CGFloat = 0
    @State private var selectedImageURL: URL? = nil
    @State private var opacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack {
                xButton
                Spacer()
                profileView
                
                Text((friend.displayName?.isEmpty == false) ? friend.displayName! : friend.uid)
                    .foregroundStyle((friend.displayName?.isEmpty == false) ? .white : .gray)
                
                whiteLine
                    .padding(.top, 30)
                bottomSection
                    .padding(.top)
            }
            
            if let selectedImageURL {
                FullScreenImageView(url: $selectedImageURL)
            }
        }
        .offset(y: viewOffset)
        .gesture (
            DragGesture(minimumDistance: 15)
                .onChanged { gesture in
                    guard gesture.translation.height > 0 else { return }
                    viewOffset = gesture.translation.height
                }
                .onEnded { gesture in
                    let dismissableLocation = gesture.translation.height > 150
                    let dismissableVolocity = gesture.velocity.height > 150
                    if dismissableLocation || dismissableVolocity {
                        dismiss()
                    } else {
                        dragViewUp()
                    }
                }
        )
        .opacity(opacity)
        .onAppear {
            withAnimation {
                opacity = 1
            }
        }
    }
    
    var backgroundView: some View {
        Rectangle()
            .fill(.clear)
            .background {
                ZStack {
                    Rectangle()
                        .fill(.gray)
                    
                    if let url = friend.backgroundImageURL {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .onTapGesture {
                                selectedImageURL = url
                            }
                    }
                }
            }
            .ignoresSafeArea()
    }
    
    var xButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .font(.title)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var profileView: some View {
        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
            .stroke(.white.opacity(0.6))
            .fill(.clear)
            .frame(width: 100, height: 100)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(.gray)
                    
                    Image(systemName: "person")
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    if let url = friend.photoURL {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            .onTapGesture {
                                selectedImageURL = url
                            }
                    }
                }
            }
    }
    
    var whiteLine: some View {
        Rectangle()
            .fill(.white.opacity(0.7))
            .frame(height: 1)
    }
    
    var bottomSection: some View {
        HStack(spacing: 40) {
            
            if let link = friend.link {
                Button {
                    URLManager.shared.open(url: link)
                } label: {
                    VStack(spacing: 12) {
                        Image(systemName: "link")
                        Text("Link")
                    }
                }
                .foregroundStyle(.white)
            }
            
            Button {
                URLManager.shared.open(url: "dgmuscle://friendhistory?id=\(friend.uid)")
            } label: {
                VStack(spacing: 12) {
                    Image(systemName: "doc.richtext.ko")
                    Text("Exercise Record")
                }
            }
            .foregroundStyle(.white)
        }
    }
    
    private func dismiss() {
        withAnimation {
            viewOffset = 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                selectedFriend = nil
            }
        }
    }
    
    private func dragViewUp() {
        withAnimation {
            viewOffset = 0
        }
    }
}

#Preview {
    FriendProfileView(
        friend: .init(domain: USER_DG),
        selectedFriend: .constant(.init(domain: USER_DG))
    )
    .preferredColorScheme(.dark)
}
