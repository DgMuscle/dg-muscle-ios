//
//  FriendRequestListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import SwiftUI
import Kingfisher

struct FriendRequestListView: View {
    @StateObject var viewModel: FriendRequestListViewModel
    
    var body: some View {
        List {
            Section("Requests") {
                ForEach(viewModel.requests, id: \.self) { request in
                    VStack {
                        HStack {
                            if let profileUrl = request.sender?.photoURL {
                                let size: CGFloat = 45
                                KFImage(profileUrl)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: size, height: size)
                            }
                            
                            Text(request.sender?.displayName ?? "Don't have display name")
                            
                            Spacer()
                            
                            Button {
                                viewModel.accept(request: request)
                            } label: {
                                Text("Accept")
                            }
                            .buttonStyle(.borderless)
                            
                            Button {
                                viewModel.refuse(request: request)
                            } label: {
                                Text("Refuse")
                            }
                            .buttonStyle(.borderless)
                        }
                        
                        HStack {
                            Spacer()
                            Text(request.createdAtString)
                        }
                    }
                    
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let friendRepository: FriendRepository = FriendRepositoryTest()
    let userRepository: UserRepository = UserRepositoryTest()
    return FriendRequestListView(viewModel: .init(subscribeFriendRequestsUsecase: .init(friendRepository: friendRepository),
                                                  acceptFriendUsecase: .init(friendRepository: friendRepository),
                                                  refuseFriendUsecase: .init(friendRepository: friendRepository),
                                                  getUserFromUserIdUsecase: .init(userRepository: userRepository)))
    .preferredColorScheme(.dark)
}
