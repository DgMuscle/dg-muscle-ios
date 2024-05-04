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
    @EnvironmentObject var coordinator: CoordinatorV2
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
            }
        }
        .navigationTitle("Friends")
        .scrollIndicators(.hidden)
        .overlay {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FriendListOptionsView(hasRequest: viewModel.hasRequest) {
                        print("move to request page")
                    } searchAction: {
                        coordinator.friend.search()
                    }
                }
            }
        }
    }
}

#Preview {
    let friendRepository: FriendRepository = FriendRepositoryTest()
    var viewModel: FriendListViewModel = .init(getMyFriendsUsecase: 
            .init(friendRepository: friendRepository),
                                               subscribeFriendRequestsUsecase:
            .init(friendRepository: friendRepository))
    return FriendListView(viewModel: viewModel).preferredColorScheme(.dark)
        .environmentObject(CoordinatorV2(path: .constant(.init())))
}
