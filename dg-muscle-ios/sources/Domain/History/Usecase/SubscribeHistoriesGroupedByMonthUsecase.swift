//
//  SubscribeHistoriesGroupedByMonthUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine

public final class SubscribeHistoriesGroupedByMonthUsecase {
    @Published private var historiesGroupedByMonth: [String:[History]] = [:]
    private let historyRepository: HistoryRepository
    private let groupByMonthHistoriesUsecase: GroupByMonthHistoriesUsecase
    private var cancellables = Set<AnyCancellable>()
    
    public init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
        self.groupByMonthHistoriesUsecase = .init()
    }
    
    public func implement() -> AnyPublisher<[String:[History]], Never> {
        historyRepository
            .histories
            .sink { [weak self] histories in
                guard let self else { return }
                historiesGroupedByMonth = groupByMonthHistoriesUsecase.implement(histories: histories)
            }
            .store(in: &cancellables)
            
        return $historiesGroupedByMonth.eraseToAnyPublisher()
    }
}
