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
    private let historyRepo: HistoryRepository
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter
    }()
    
    @Published private var groupedHistories: [[HistoryDomain]] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(historyRepo: HistoryRepository) {
        self.historyRepo = historyRepo
        bind()
    }
    
    func implement() -> AnyPublisher<[[HistoryDomain]], Never> {
        $groupedHistories.eraseToAnyPublisher()
    }
    
    private func bind() {
        historyRepo.historiesPublisher
            .sink { [weak self] histories in
                guard let self else { return }
                groupedHistories = group(histories: histories)
            }
            .store(in: &cancellables)
    }
    
    private func group(histories: [HistoryDomain]) -> [[HistoryDomain]] {
        var group: [[HistoryDomain]] = []
        
        var hashMap: [String: [HistoryDomain]] = [:]
        
        for history in histories {
            let yearMonth = dateFormatter.string(from: history.date)
            hashMap[yearMonth, default: []].append(history)
        }
        
        var keys = hashMap.map({ $0.key })
        
        keys = keys.sorted().reversed()
        
        for key in keys {
            if let histories = hashMap[key] {
                group.append(histories)
            }
        }
        
        return group
    }
}
