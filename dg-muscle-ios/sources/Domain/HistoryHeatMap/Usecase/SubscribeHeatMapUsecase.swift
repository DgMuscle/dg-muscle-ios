//
//  SubscribeHeatMapUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/15/24.
//

import Foundation
import Combine

public final class SubscribeHeatMapUsecase {
    @Published var heatMap: [HeatMap] = []
    
    let today: Date
    let historyRepository: HistoryRepository
    let heatMapRepository: HeatMapRepository
    private var cancellables = Set<AnyCancellable>()
    public init(today: Date,
                historyRepository: HistoryRepository,
                heatMapRepository: HeatMapRepository) {
        self.today = today
        self.historyRepository = historyRepository
        self.heatMapRepository = heatMapRepository
        bind()
    }
    public func implement() -> AnyPublisher<[HeatMap], Never> {
        $heatMap.eraseToAnyPublisher()
    }
    
    private func bind() {
        historyRepository
            .histories
            .sink { [weak self] histories in
                guard let self else { return }
                let usecase = GetHeatMapUsecase(today: today)
                heatMap = usecase.implement(histories: histories)
                heatMapRepository.post(heatMap: heatMap)
            }
            .store(in: &cancellables)
    }
}
