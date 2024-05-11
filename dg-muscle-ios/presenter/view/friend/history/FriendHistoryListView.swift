//
//  FriendHistoryListView.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import SwiftUI
import Kingfisher

struct FriendHistoryListView: View {
    
    @StateObject var viewModel: FriendHistoryListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Currently you are seeing")
                if let url = viewModel.friend.photoURL {
                    KFImage(url).resizable().clipShape(Circle())
                        .frame(width: 30, height: 30)
                }
                Text("\(viewModel.friend.displayName ?? viewModel.friend.uid)'s data")
                Spacer()
            }
            .font(.caption2)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemGroupedBackground))
            )
            
            ScrollView {
                HeatMap(datas: viewModel.heatmap, color: viewModel.heatmapColor)
                    .padding(.bottom)
                    .scrollTransition { effect, phase in
                        effect.scaleEffect(phase.isIdentity ? 1 : 0.75)
                    }
                
                ForEach(viewModel.sections) { section in
                    FriendHistorySectionView(section: section,
                                             friend: viewModel.friend,
                                             exercises: viewModel.exercises,
                                             color: viewModel.heatmapColor)
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let historyRepository: HistoryRepository = HistoryRepositoryTest()
    let exerciseRepository: ExerciseRepository = ExerciseRepositoryTest()
    let friendRepository = FriendRepositoryTest()
    let friend: UserV = .init(from: FriendRepositoryTest().friends[0])
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    let date = dateFormatter.date(from: "20240415")!
    
    return FriendHistoryListView(viewModel: .init(friend: friend,
                                                  getFriendGroupedHistoriesUsecase: .init(historyRepository: historyRepository),
                                                  getHistoriesFromUidUsecase: .init(friendRepository: friendRepository),
                                                  generateHeatmapFromHistoryUsecase: .init(today: date),
                                                  getFriendExercisesUsecase: .init(friendRepository: friendRepository)))
    .preferredColorScheme(.dark)
}
