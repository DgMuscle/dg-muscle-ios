//
//  FriendRequestListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import SwiftUI

struct FriendRequestListView: View {
    @StateObject var viewModel: FriendRequestListViewModel
    var body: some View {
        List {
            Text("Friend Request List View")
        }
        .scrollIndicators(.hidden)
    }
}
