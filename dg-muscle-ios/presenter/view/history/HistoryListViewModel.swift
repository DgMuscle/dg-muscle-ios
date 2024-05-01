//
//  HistoryListViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HistoryListViewModel: ObservableObject {
    @Published var sections: [HistorySectionV] = []
    @Published var user: UserV? = nil
    
    let subscribeGroupedHistoriesUsecase: SubscribeGroupedHistoriesUsecase
    let subscribeMetaDatasMapUsecase: SubscribeMetaDatasMapUsecase
    let subscribeUserUsecase: SubscribeUserUsecase
    let getTodayHistoryUsecase: GetTodayHistoryUsecase
    let deleteHistoryUsecase: DeleteHistoryUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        subscribeGroupedHistoriesUsecase: SubscribeGroupedHistoriesUsecase,
        subscribeMetaDatasMapUsecase: SubscribeMetaDatasMapUsecase,
        subscribeUserUsecase: SubscribeUserUsecase,
        getTodayHistoryUsecase: GetTodayHistoryUsecase,
        deleteHistoryUsecase: DeleteHistoryUsecase
    ) {
        self.subscribeGroupedHistoriesUsecase = subscribeGroupedHistoriesUsecase
        self.subscribeMetaDatasMapUsecase = subscribeMetaDatasMapUsecase
        self.subscribeUserUsecase = subscribeUserUsecase
        self.getTodayHistoryUsecase = getTodayHistoryUsecase
        self.deleteHistoryUsecase = deleteHistoryUsecase
        bind()
    }
    
    func delete(history: HistoryV) {
        deleteHistoryUsecase.implement(history: history.domain)
    }
    
    func todayHistory() -> HistoryV? {
        guard let todayHistory = getTodayHistoryUsecase.implement() else { return nil }
        return HistoryV(from: todayHistory)
    }
    
    private func bind() {
        subscribeGroupedHistoriesUsecase.implement()
            .combineLatest(subscribeMetaDatasMapUsecase.implement())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] groupedHistories, metadatasMap in
                guard let self else { return }
                sections = combineHistoriesAndMetaDatas(groupedHistories: groupedHistories, metadatasMap: metadatasMap)
            }
            .store(in: &cancellables)
        
        subscribeUserUsecase.implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                if let user {
                    self?.user = .init(from: user)
                } else {
                    self?.user = nil
                }
            }
            .store(in: &cancellables)
    }
    
    private func combineHistoriesAndMetaDatas(groupedHistories: [[HistoryDomain]], metadatasMap: [String: HistoryMetaDataDomain]) -> [HistorySectionV] {
        let groupedHistories: [[HistoryV]] = groupedHistories.map({ $0.map({ .init(from: $0) }) })
        var hashMap: [String: HistoryMetaDataV] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        for (key, value) in metadatasMap {
            hashMap[key] = .init(from: value)
        }
        
        var combinedHistories: [[HistoryV]] = []
        
        for histories in groupedHistories {
            var converted: [HistoryV] = []
            for history in histories {
                var history = history
                if let metadata = hashMap[dateFormatter.string(from: history.date)] {
                    history.metaData = metadata
                }
                converted.append(history)
            }
            combinedHistories.append(converted)
        }
        
        let sections: [HistorySectionV] = combinedHistories.map({ .init(histories: $0) })
        return sections
    }
}
