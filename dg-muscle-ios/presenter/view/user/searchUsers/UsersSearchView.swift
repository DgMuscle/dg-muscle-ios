//
//  UsersSearchView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import SwiftUI

struct UsersSearchView: View {
    @StateObject var viewModel: UsersSearchViewModel
    var body: some View {
        VStack {
            HStack {
                TextField("Search user by display name", text: $viewModel.query)
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
                            Text(user.displayName ?? "no display name")
                            Spacer()
                            
                            if user.isMyFriend == false {
                                Button {
                                    print("send friend request")
                                } label: {
                                    HStack(spacing: 3) {
                                        Text("SEND")
                                        Image(systemName: "paperplane")
                                    }
                                }
                            }
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8).fill(user.isMyFriend ?
                                                                   LinearGradient(colors: [.yellow.opacity(0.1), .yellow.opacity(0.4)],
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
        .animation(.default, value: viewModel.searchedUsers.isEmpty)
    }
}

#Preview {
    let userRepository: UserRepository = UserRepositoryTest()
    let friendRepository: FriendRepository = FriendRepositoryTest()
    var viewModel: UsersSearchViewModel = .init(searchUsersByDisplayNameUsecase: .init(userRepository: userRepository),
                                                getMyFriendsUsecase: .init(friendRepository: friendRepository))
    viewModel.query = "Hui"
    return UsersSearchView(viewModel: viewModel)
    .preferredColorScheme(.dark)
}
