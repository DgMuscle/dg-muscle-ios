//
//  PostHistoryViewModel.swift
//  History
//
//  Created by 신동규 on 5/22/24.
//

import Foundation
import Combine
import Domain

class PostHistoryViewModel: ObservableObject {
    
    private let postHistoryUsecase: PostHistoryUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepository) {
        postHistoryUsecase = .init(historyRepository: historyRepository)
    }
}
