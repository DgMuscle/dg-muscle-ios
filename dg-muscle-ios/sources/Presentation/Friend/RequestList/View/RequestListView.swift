//
//  RequestListView.swift
//  Friend
//
//  Created by 신동규 on 5/26/24.
//

import SwiftUI
import Domain
import MockData
import Kingfisher

struct RequestListView: View {
    
    @StateObject var viewModel: RequestListViewModel
    @State var selectedRequest: FriendRequest?
    private let imageSize: CGFloat = 50
    
    init(
        friendRepository: FriendRepository,
        userRepository: UserRepository
    ) {
        _viewModel = .init(wrappedValue: .init(friendRepository: friendRepository,
                                               userRepository: userRepository))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.requests, id: \.self) { request in
                Button {
                    selectedRequest = request
                } label: {
                    FriendListItemView(friend: .init(domain: request.user.domain) )
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
        }
        .scrollIndicators(.hidden)
        .sheet(item: $selectedRequest) { request in
            RequestManageView(request: request, accept: { request in
                selectedRequest = nil
                viewModel.accept(request: request)
            }, refuse: { request in
                selectedRequest = nil
                viewModel.refuse(request: request)
            }, color: viewModel.color)
            .presentationDetents([.height(250)])
        }
    }
}

#Preview {
    RequestListView(
        friendRepository: FriendRepositoryMock(),
        userRepository: UserRepositoryMock()
    )
    .preferredColorScheme(.dark)
}
