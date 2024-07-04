//
//  SubscribeDateToSelectHistoryUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/4/24.
//

import Foundation
import Combine

public final class SubscribeDateToSelectHistoryUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement() -> PassthroughSubject<Date, Never> {
        historyRepository.dateToSelectHistory
    }
}
