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
    private let heatmapRepository: HeatmapRepository
    private let generateHeatmapFromHistoryUsecase: GenerateHeatmapFromHistoryUsecase
    
    @Published private var heatMaps: [HeatmapDomain] = []
    
    private var cancellables = Set<AnyCancellable>()
    init(historyRepository: HistoryRepository, 
         today: Date,
         heatmapRepository: HeatmapRepository) {
        self.historyRepository = historyRepository
        self.today = today
        self.heatmapRepository = heatmapRepository
        self.generateHeatmapFromHistoryUsecase = .init(today: today)
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
                heatMaps = generateHeatmapFromHistoryUsecase.implement(histories: histories)
                try? heatmapRepository.post(data: heatMaps)
            }
            .store(in: &cancellables)
    }
}
