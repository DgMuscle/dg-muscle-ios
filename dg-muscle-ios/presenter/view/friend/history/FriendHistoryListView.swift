//
//  FriendHistoryListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import SwiftUI

struct FriendHistoryListView: View {
    
    @StateObject var viewModel: FriendHistoryListViewModel
    
    var body: some View {
        VStack {
            Text("You are now seeing other's data")
            ScrollView {
                HeatMap(datas: viewModel.heatmap, color: viewModel.heatmapColor)
                
                
            }
            .scrollIndicators(.hidden)
        }
        .padding()
    }
}
