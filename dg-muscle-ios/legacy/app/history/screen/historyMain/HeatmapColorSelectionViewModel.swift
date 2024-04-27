//
//  HeatmapColorSelectionViewModel.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/18/24.
//

import Combine
import Foundation

final class HeatmapColorSelectionViewModel: ObservableObject {
    @Published var selectedColor: HeatmapColor
    @Published var allColors = HeatmapColor.allCases
    
    let heatmapRepository: HeatmapRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(heatmapRepository: HeatmapRepository) {
        self.heatmapRepository = heatmapRepository
        self.selectedColor = heatmapRepository.color
        bind()
    }
    
    func tap(color: HeatmapColor) {
        selectedColor = color
        try? heatmapRepository.post(color: color)
    }
    
    private func bind() {
        heatmapRepository
            .colorPublisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] color in
                self?.selectedColor = color
            }
            .store(in: &cancellables)
    }
}
