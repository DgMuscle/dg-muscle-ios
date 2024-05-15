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
    private var cancellables = Set<AnyCancellable>()
    public init(today: Date,
                historyRepository: HistoryRepository) {
        self.today = today
        self.historyRepository = historyRepository
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
            }
            .store(in: &cancellables)
    }
}
