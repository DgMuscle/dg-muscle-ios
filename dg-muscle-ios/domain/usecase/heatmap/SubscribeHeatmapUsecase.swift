//
//  SubscribeHeatmapUsecase.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class SubscribeHeatmapUsecase {
    private let historyRepository: HistoryRepository
    private let today: Date
    private let getHeatmapUsecase: GetHeatmapUsecase
    
    @Published private var heatMaps: [HeatmapDomain] = []
    
    private var cancellables = Set<AnyCancellable>()
    init(historyRepository: HistoryRepository, today: Date) {
        self.historyRepository = historyRepository
        self.today = today
        self.getHeatmapUsecase = .init(historyRepository: historyRepository, today: today)
        bind()
    }
    
    func implement() -> AnyPublisher<[HeatmapDomain], Never> {
        $heatMaps.eraseToAnyPublisher()
    }
    
    private func bind() {
        historyRepository
            .historiesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] histories in
                guard let self else { return }
                heatMaps = getHeatmapUsecase.implement()
            }
            .store(in: &cancellables)
    }
}
