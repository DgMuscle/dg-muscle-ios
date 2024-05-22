//
//  PostHistoryUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/22/24.
//

import Foundation

public final class PostHistoryUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement(history: History) {
        Task {
            try await historyRepository.post(history: history)
        }
    }
}
