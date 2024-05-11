//
//  UsersSearchView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import SwiftUI
import Kingfisher

struct UsersSearchView: View {
    @StateObject var viewModel: UsersSearchViewModel
    var body: some View {
        VStack {
            
            if viewModel.loading {
                BannerLoadingView(loading: $viewModel.loading)
            }
            
            if let errorMessage = viewModel.errorMessage {
                BannerErrorMessageView(errorMessage: errorMessage)
            }
            
            if viewModel.success {
                BannerSuccessView(message: "Request Completed")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.success.toggle()
                        }
                    }
            }
            
            HStack {
                TextField("Search user by display name", text: $viewModel.query)
                    .autocorrectionDisabled()
                    .padding(.horizontal)
                if viewModel.query.isEmpty == false {
                    Button {
                        viewModel.removeQuery()
                    } label: {
                        Image(systemName: "xmark").foregroundStyle(.white)
                            .font(.caption2)
                            .padding(8)
                            .background(
                                Circle().fill(Color(uiColor: .secondarySystemBackground))
                            )
                    }
                }
            }
            .padding(4)
            .background(
                Capsule().fill(Color(uiColor: .secondarySystemGroupedBackground))
            )
            
            if viewModel.searchedUsers.isEmpty == false {
                HStack {
                    Text("Searched Users").foregroundStyle(.secondary)
                        .font(.caption)
                    Spacer()
                }
                .transition(.move(edge: .top))
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    ForEach(viewModel.searchedUsers, id: \.self) { user in
                        
                        HStack {
                            let size: CGFloat = 30
                            if let url = user.photoURL {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: size, height: size)
                            } else {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width:0, height: size)
                            }
                            
                            Text(user.displayName ?? user.uid)
                            Spacer()
                            
                            if user.isMyFriend == false {
                                Button {
                                    viewModel.sendRequest(user: user)
                                } label: {
                                    HStack(spacing: 3) {
                                        Text("SEND")
                                        Image(systemName: "paperplane")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8).fill(user.isMyFriend ?
                                                                   LinearGradient(colors: [.blue.opacity(0.1), .blue.opacity(0.4)],
                                                                                  startPoint: .leading,
                                                                                  endPoint: .trailing) :
                                                                    LinearGradient(colors: [Color(uiColor: .secondarySystemGroupedBackground)], startPoint: .leading, endPoint: .trailing)
                                                                  )
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: viewModel.searchedUsers.isEmpty)
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.success)
    }
}

#Preview {
    let userRepository: UserRepository = UserRepositoryTest()
    let friendRepository: FriendRepository = FriendRepositoryTest()
    var viewModel: UsersSearchViewModel = .init(searchUsersByDisplayNameUsecase: .init(userRepository: userRepository),
                                                getMyFriendsUsecase: .init(friendRepository: friendRepository), 
                                                getUserUsecase: .init(userRepository: userRepository), 
                                                postFriendRequestUsecase: .init(friendRepository: friendRepository))
    viewModel.query = "낙"
    return UsersSearchView(viewModel: viewModel)
    .preferredColorScheme(.dark)
}
