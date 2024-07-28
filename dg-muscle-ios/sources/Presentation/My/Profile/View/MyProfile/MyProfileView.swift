//
//  MyProfileView.swift
//  My
//
//  Created by 신동규 on 5/25/24.
//

import Foundation
import SwiftUI
import Domain
import MockData
import Common
import Kingfisher

public struct MyProfileView: View {
    
    @Binding var shows: Bool
    
    @State private var viewOffset: CGFloat = 0
    
    @StateObject var viewModel: MyProfileViewModel
    
    public init(
        shows: Binding<Bool>,
        userRepository: UserRepository
    ) {
        _shows = shows
        _viewModel = .init(wrappedValue: .init(userRepository: userRepository))
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background {
                    ZStack {
                        Rectangle()
                            .fill(Color(uiColor: .secondarySystemGroupedBackground))
                        
                        if let url = viewModel.user?.backgroundImageURL {
                            KFImage(url)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                }
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(.white.opacity(0.6))
                    .fill(.clear)
                    .frame(width: 100, height: 100)
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .fill(Color(uiColor: .secondarySystemBackground))
                            
                            Image(systemName: "person")
                                .font(.title)
                                .foregroundStyle(.white)
                            
                            if let url = viewModel.user?.photoURL {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            }
                        }
                    }
                
                let name = viewModel.user?.displayName ?? "name"
                
                Text(name)
                    .foregroundStyle(.white)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                    .padding(.top, 30)
                    
                
                HStack(spacing: 40) {
                    
                    if let link = viewModel.user?.link {
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
                        print("tap edit")
                    } label: {
                        VStack(spacing: 12) {
                            Image(systemName: "pencil")
                            Text("Edit")
                        }
                    }
                    .foregroundStyle(.white)
                }
                .padding(.top)
                
                
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
                        withAnimation {
                            viewOffset = 1000
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                shows = false
                            }
                        }
                    } else {
                        withAnimation {
                            viewOffset = 0
                        }
                    }
                }
        )
        
    }
}

#Preview {
    return MyProfileView(
        shows: .constant(true),
        userRepository: UserRepositoryMock()
    )
//        .preferredColorScheme(.dark)
}