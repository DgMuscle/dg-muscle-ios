//
//  GetDayUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation

final class GetDayUsecase {
    let history: HistoryDomain
    
    init(history: HistoryDomain) {
        self.history = history
    }
    
    func implement() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: history.date)
    }
}
