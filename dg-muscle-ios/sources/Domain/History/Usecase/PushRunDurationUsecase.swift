//
//  PushRunDurationUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/28/24.
//

import Foundation
import Combine

public final class PushRunDurationUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement(duration: Int) {
        historyRepository.runDurationSubject.send(duration)
    }
}
