//
//  SubscribeGroupedHistoriesUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

// history 데이터를 월별로 묶어서 2차 배열로 반환해준다
final class SubscribeGroupedHistoriesUsecase {
    private let historyRepository: HistoryRepository
    
    @Published private var groupedHistories: [[HistoryDomain]] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
        bind()
    }
    
    func implement() -> AnyPublisher<[[HistoryDomain]], Never> {
        $groupedHistories.eraseToAnyPublisher()
    }
    
    private func bind() {
        historyRepository.historiesPublisher
            .sink { [weak self] histories in
                guard let self else { return }
                groupedHistories = GetGroupedHistoriesUsecase().implement(histories: histories)
            }
            .store(in: &cancellables)
    }
}
