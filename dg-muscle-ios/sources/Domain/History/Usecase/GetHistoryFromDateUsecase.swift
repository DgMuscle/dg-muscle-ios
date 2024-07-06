//
//  GetHistoryFromDateUsecase.swift
//  Domain
//
//  Created by 신동규 on 7/4/24.
//

import Foundation

public final class GetHistoryFromDateUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement(date: Date) -> History? {
        historyRepository.get().first(where: {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        })
    }
}
