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
    
    private var cancellables = Set<AnyCancellable>()
    init() {
        bind()
    }
    
    private func bind() {
        
    }
}
