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
        VStack {
            VStack {
                if let successMessage = viewModel.successMessage {
                    BannerSuccessView(message: successMessage)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                viewModel.successMessage = nil
                            }
                        }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    BannerErrorMessageView(errorMessage: errorMessage)
                }
                
                if viewModel.loading {
                    BannerLoadingView(loading: $viewModel.loading)
                }
            }.padding(.horizontal)
            
            List {
                Section("Requests") {
                    ForEach(viewModel.requests, id: \.self) { request in
                        VStack {
                            HStack {
                                if let profileUrl = request.sender?.photoURL {
                                    let size: CGFloat = 40
                                    KFImage(profileUrl)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: size, height: size)
                                }
                                
                                Text(request.sender?.displayName ?? "Don't have display name")
                                    .font(.callout)
                                
                                Spacer()
                                
                                Button {
                                    viewModel.accept(request: request)
                                } label: {
                                    Text("Accept").fontWeight(.bold)
                                }
                                .buttonStyle(.borderless)
                                
                                Button {
                                    viewModel.refuse(request: request)
                                } label: {
                                    Text("Refuse").foregroundStyle(.secondary)
                                }
                                .buttonStyle(.borderless)
                            }
                            
                            HStack {
                                Spacer()
                                Text(request.createdAtString).foregroundStyle(.secondary).font(.caption)
                            }
                        }
                        
                    }
                }
            }
        }
        .animation(.default, value: viewModel.successMessage)
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.loading)
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let friendRepository: FriendRepository = FriendRepositoryTest()
    let userRepository: UserRepository = UserRepositoryTest()
    return FriendRequestListView(viewModel: .init(subscribeFriendRequestsUsecase: .init(friendRepository: friendRepository),
                                                  acceptFriendUsecase: .init(friendRepository: friendRepository),
                                                  refuseFriendUsecase: .init(friendRepository: friendRepository),
                                                  getUserFromUserIdUsecase: .init(userRepository: userRepository), 
                                                  updateFriendsUsecase: .init(friendRepository: friendRepository)))
    .preferredColorScheme(.dark)
}
