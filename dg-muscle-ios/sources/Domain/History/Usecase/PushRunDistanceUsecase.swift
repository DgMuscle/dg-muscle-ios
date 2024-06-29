//
//  PushRunDistanceUsecase.swift
//  Domain
//
//  Created by 신동규 on 6/28/24.
//

import Foundation
import Combine

public final class PushRunDistanceUsecase {
    private let historyRepository: HistoryRepository
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    public func implement(distance: Double) {
        historyRepository.runDistanceSubject.send(distance)
    }
}
