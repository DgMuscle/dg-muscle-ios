//
//  HeatmapViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import Combine

final class HeatmapViewModel: ObservableObject {
    
    @Published var datas: [HeatmapV] = []
    @Published var color: HeatmapColorV = .green
    
    private let subscribeHeatmapUsecase: SubscribeHeatmapUsecase
    private let subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase
    
    private var cancellables = Set<AnyCancellable>()
    
    init(subscribeHeatmapUsecase: SubscribeHeatmapUsecase,
         subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase) {
        self.subscribeHeatmapUsecase = subscribeHeatmapUsecase
        self.subscribeHeatmapColorUsecase = subscribeHeatmapColorUsecase
        bind()
    }
    
    private func bind() {
        subscribeHeatmapUsecase.implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] datas in
                self?.datas = datas.map({ .init(from: $0) })
            }
            .store(in: &cancellables)
        
        subscribeHeatmapColorUsecase.implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] color in
                self?.color = .init(color: color)
            }
            .store(in: &cancellables)
    }
}
