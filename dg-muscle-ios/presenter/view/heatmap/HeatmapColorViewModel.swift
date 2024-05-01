//
//  HeatmapColorViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/1/24.
//

import Foundation
import Combine

final class HeatmapColorViewModel: ObservableObject {
    @Published var selectedColor: HeatmapColorV
    let allColors = HeatmapColorV.allCases
    
    private let postHeatmapColorUsecase: PostHeatmapColorUsecase
    private let subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase
    private let getHeatmapColorUsecase: GetHeatmapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(postHeatmapColorUsecase: PostHeatmapColorUsecase, subscribeHeatmapColorUsecase: SubscribeHeatmapColorUsecase, getHeatmapColorUsecase: GetHeatmapColorUsecase) {
        self.postHeatmapColorUsecase = postHeatmapColorUsecase
        self.subscribeHeatmapColorUsecase = subscribeHeatmapColorUsecase
        self.getHeatmapColorUsecase = getHeatmapColorUsecase
        
        selectedColor = .init(color: getHeatmapColorUsecase.implement())
        bind()
    }
    
    func updateColor(color: HeatmapColorV) {
        postHeatmapColorUsecase.implement(data: color.domain)
    }
    
    private func bind() {
        subscribeHeatmapColorUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] color in
                self?.selectedColor = .init(color: color)
            }
            .store(in: &cancellables)
    }
}
