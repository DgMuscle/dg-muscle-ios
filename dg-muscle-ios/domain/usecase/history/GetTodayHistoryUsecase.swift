//
//  GetTodayHistoryUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetTodayHistoryUsecase {
    let historyRepository: HistoryRepository
    let today: Date
    
    init(historyRepository: HistoryRepository, today: Date) {
        self.historyRepository = historyRepository
        self.today = today
    }
    
    func implement() -> HistoryDomain? {
        let histories = historyRepository.histories
        return histories.first(where: { Calendar.current.isDate(today, inSameDayAs: $0.date) })
    }
}
