//
//  FriendHistoryView.swift
//  Friend
//
//  Created by Donggyu Shin on 6/14/24.
//

import SwiftUI
import Domain
import MockData
import Common
import Kingfisher

public struct FriendHistoryView: View {
    
    @StateObject var viewModel: FriendHistoryViewModel
    
    public init(
        friendRepository: any FriendRepository,
        friendId: String
    ) {
        _viewModel = .init(wrappedValue: .init(
            friendRepository: friendRepository,
            friendId: friendId
        ))
    }
    
    public var body: some View {
        List {
            if let status = viewModel.status {
                switch status {
                case .loading:
                    StatusView(status: status)
                case .success, .error:
                    StatusView(status: status)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                viewModel.status = nil
                            }
                        }
                }
            }
            
            ForEach(viewModel.historySection, id: \.self) { section in
                Section {
                    VStack(spacing: 12) {
                        ForEach(section.histories, id: \.self) { history in
                            Button {
                                print("tap")
                            } label: {
                                Common.HistoryItemView(history: history)
                            }
                        }
                    }
                    .padding(.bottom)
                } header: {
                    HStack {
                        Text(section.yearMonth)
                            .font(.system(size: 20))
                            .fontWeight(.black)
                        Spacer()
                    }
                    .padding(.bottom)
                }
            }
            
        }
        .scrollIndicators(.hidden)
        .animation(.default, value: viewModel.status)
        .toolbar {
            if let user = viewModel.user {
                if let profileImage = user.photoURL {
                    KFImage(profileImage)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                
                if let displayName = user.displayName {
                    Text(displayName)
                }
            }
        }
    }
}

#Preview {
    return NavigationStack {
        FriendHistoryView(
            friendRepository: FriendRepositoryMock(),
            friendId: USER_DG.uid
        )
    }
    .preferredColorScheme(
        .dark
    )
}
