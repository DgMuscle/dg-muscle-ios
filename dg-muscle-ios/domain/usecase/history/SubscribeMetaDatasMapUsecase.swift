//
//  SubscribeMetaDatasMapUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

// metadata를 날짜별로 묶어서 반환해준다.
final class SubscribeMetaDatasMapUsecase {
    private let healthRepository: HealthRepositoryDomain
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
    
    @Published private var metadataMap: [String: HistoryMetaDataDomain] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    init(healthRepository: HealthRepositoryDomain) {
        self.healthRepository = healthRepository
        bind()
    }
    
    func implement() -> AnyPublisher<[String: HistoryMetaDataDomain], Never> {
        $metadataMap.eraseToAnyPublisher()
    }
    
    private func bind() {
        healthRepository.historyMetaDatasPublisher
            .sink { [weak self] metadatas in
                guard let self else { return }
                metadataMap = group(metadatas: metadatas)
            }
            .store(in: &cancellables)
    }
    
    private func group(metadatas: [HistoryMetaDataDomain]) -> [String: HistoryMetaDataDomain] {
        var map: [String: HistoryMetaDataDomain] = [:]
        
        for data in metadatas {
            let date = dateFormatter.string(from: data.startDate)
            map[date] = data
        }
        
        return map
    }
}
