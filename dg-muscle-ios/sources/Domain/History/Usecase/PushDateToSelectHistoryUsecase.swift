//
//  PushDateToSelectHistoryUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/4/24.
//

import Foundation

public final class PushDateToSelectHistoryUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement(date: Date) {
        historyRepository.dateToSelectHistory.send(date)
    }
}
