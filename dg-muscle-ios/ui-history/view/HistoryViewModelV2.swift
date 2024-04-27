//
//  HistoryViewModelV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HistoryViewModelV2: ObservableObject {
    @Published var sections: [HistorySectionV] = []
    
    let getGroupedHistoriesUsecase: GetGroupedHistoriesUsecase
    let getMetaDatasMapUsecase: GetMetaDatasMapUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getGroupedHistoriesUsecase: GetGroupedHistoriesUsecase,
        getMetaDatasMapUsecase: GetMetaDatasMapUsecase
    ) {
        self.getGroupedHistoriesUsecase = getGroupedHistoriesUsecase
        self.getMetaDatasMapUsecase = getMetaDatasMapUsecase
        bind()
    }
    
    private func bind() {
        getGroupedHistoriesUsecase.implement()
            .combineLatest(getMetaDatasMapUsecase.implement())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] groupedHistories, metadatasMap in
                guard let self else { return }
                sections = combineHistoriesAndMetaDatas(groupedHistories: groupedHistories, metadatasMap: metadatasMap)
            }
            .store(in: &cancellables)
    }
    
    private func combineHistoriesAndMetaDatas(groupedHistories: [[HistoryDomain]], metadatasMap: [String: HistoryMetaDataDomain]) -> [HistorySectionV] {
        let groupedHistories: [[HistoryV]] = groupedHistories.map({ $0.map({ .init(from: $0) }) })
        var metadatasMap: [String: HistoryMetaDataV] = [:]
        
        for (key, value) in metadatasMap {
            metadatasMap[key] = value
        }
        
        var combinedHistories: [[HistoryV]] = []
        
        for histories in groupedHistories {
            var converted: [HistoryV] = []
            for history in histories {
                var history = history
                if let metadata = metadatasMap[history.date] {
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
