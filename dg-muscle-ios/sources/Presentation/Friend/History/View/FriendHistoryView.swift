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
import HistoryHeatMap

public struct FriendHistoryView: View {
    
    @StateObject var viewModel: FriendHistoryViewModel
    
    public init(
        friendRepository: any FriendRepository,
        friendId: String,
        today: Date
    ) {
        _viewModel = .init(wrappedValue: .init(
            friendRepository: friendRepository,
            friendId: friendId, 
            today: today
        ))
    }
    
    public var body: some View {
        ScrollView {
            VStack {
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
                
                if viewModel.heatMap.isEmpty == false {
                    HistoryHeatMap.HeatMapView(
                        heatMap: viewModel.heatMap,
                        color: viewModel.user?.heatMapColor.color ?? .green
                    )
                    .padding(.bottom)
                }
                
                ForEach(viewModel.historySection, id: \.self) { section in
                    Section {
                        VStack(spacing: 12) {
                            ForEach(section.histories, id: \.self) { history in
                                Button {
                                    URLManager.shared.open(
                                        url: "dgmuscle://friendhistorydetail?friend_id=\(viewModel.friendId)&history_id=\(history.id)"
                                    )
                                } label: {
                                    Common.HistoryItemView(history: history)
                                }
                                .buttonStyle(.plain)
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
            .padding()
        }
        .scrollIndicators(.hidden)
        .animation(.default, value: viewModel.status)
        .toolbar {
            if let user = viewModel.user {
                if let profileImage = user.photoURL {
                    KFImage(profileImage)
                        .resizable()
                        .frame(width: 30, height: 30)
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
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240515")!
    
    return NavigationStack {
        FriendHistoryView(
            friendRepository: FriendRepositoryMock(),
            friendId: USER_DG.uid,
            today: date
        )
    }
    .preferredColorScheme(
        .dark
    )
}
