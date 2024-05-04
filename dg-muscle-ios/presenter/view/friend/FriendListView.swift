//
//  FriendListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import SwiftUI
import Kingfisher

struct FriendListView: View {
    @StateObject var viewModel: FriendListViewModel
    var body: some View {
        List {
            Section {
                ForEach(viewModel.friends, id: \.self) { friend in
                    Button {
                        print("tap friend")
                    } label: {
                        HStack {
                            let height: CGFloat = 45
                            if let url = friend.photoURL {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(height: height)
                                    .padding(.trailing, 8)
                            } else {
                                EmptyView().frame(width: 0, height: height)
                            }
                            
                            if let displayName = friend.displayName, displayName.isEmpty == false {
                                Text(displayName).font(.subheadline).fontWeight(.heavy)
                            } else {
                                Text(friend.uid).font(.caption).foregroundStyle(Color(uiColor: .secondaryLabel))
                            }
                            Spacer()
                        }
                        .foregroundStyle(.white)
                    }
                }
            } header: {
                VStack {
                    Button {
                        print("dg: move to search friend view")
                    } label: {
                        HStack {
                            Image(systemName: "plus.magnifyingglass")
                            Text("Search")
                        }
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(.blue)
                        )
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Friends")
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let friendRepository: FriendRepository = FriendRepositoryTest()
    var viewModel: FriendListViewModel = .init(getMyFriendsUsecase: .init(friendRepository: friendRepository))
    return FriendListView(viewModel: viewModel).preferredColorScheme(.dark)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
