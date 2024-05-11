//
//  GetHistoriesFromUidUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/11/24.
//

import Foundation

final class GetHistoriesFromUidUsecase {
    let historyRepository: HistoryRepository
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func implement(uid: String) async throws -> [HistoryDomain] {
        try await historyRepository.get(uid: uid)
    }
}
