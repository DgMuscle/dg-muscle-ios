//
//  FriendHistoryListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/5/24.
//

import Foundation
import Combine

final class FriendHistoryListViewModel: ObservableObject {
    
    @Published var sections: [HistorySectionV] = []
    @Published var heatmap: [HeatmapV] = []
    private let friendId: String
    private let getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase
    private let getHistoriesFromUidUsecase: GetHistoriesFromUidUsecase
    private let generateHeatmapFromHistoryUsecase: GenerateHeatmapFromHistoryUsecase
    private var cancellables = Set<AnyCancellable>()
    init(friendId: String,
         getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase,
         getHistoriesFromUidUsecase: GetHistoriesFromUidUsecase,
         generateHeatmapFromHistoryUsecase: GenerateHeatmapFromHistoryUsecase) {
        self.friendId = friendId
        self.getFriendGroupedHistoriesUsecase = getFriendGroupedHistoriesUsecase
        self.getHistoriesFromUidUsecase = getHistoriesFromUidUsecase
        self.generateHeatmapFromHistoryUsecase = generateHeatmapFromHistoryUsecase
        configureSections()
        configureHeatmap()
    }
    
    private func configureHeatmap() {
        Task {
            let histories = try await getHistoriesFromUidUsecase.implement(uid: friendId)
            let heatmapDomain = generateHeatmapFromHistoryUsecase.implement(histories: histories)
            let heatmap: [HeatmapV] = heatmapDomain.map({ .init(from: $0) })
            DispatchQueue.main.async { [weak self] in 
                self?.heatmap = heatmap
            }
        }
    }
    
    private func configureSections() {
        Task {
            let historiesDomain: [[HistoryDomain]] = try await getFriendGroupedHistoriesUsecase.implement(friendId: friendId)
            let historiesV: [[HistoryV]] = historiesDomain.map({ $0.map({ HistoryV(from: $0) }) })
            let sections: [HistorySectionV] = historiesV.map({ .init(histories: $0) })
            DispatchQueue.main.async { [weak self] in
                self?.sections = sections
            }
        }
    }
}
