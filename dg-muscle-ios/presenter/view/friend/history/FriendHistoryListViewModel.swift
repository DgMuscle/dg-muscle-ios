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
    private let getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase
    private var cancellables = Set<AnyCancellable>()
    init(getFriendGroupedHistoriesUsecase: GetFriendGroupedHistoriesUsecase) {
        self.getFriendGroupedHistoriesUsecase = getFriendGroupedHistoriesUsecase
        bind()
    }
    
    private func bind() {
        
    }
}
