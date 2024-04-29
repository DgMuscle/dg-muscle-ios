//
//  PostHistoryUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/30/24.
//

import Foundation

final class PostHistoryUsecase {
    let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement(data: HistoryDomain) {
        Task {
            try await historyRepository.post(data: data)
        }
    }
}
