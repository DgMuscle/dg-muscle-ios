//
//  DeleteHistoryUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class DeleteHistoryUsecase {
    let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement(history: HistoryDomain) {
        Task {
            try await historyRepository.delete(data: history)
        }
    }
}
