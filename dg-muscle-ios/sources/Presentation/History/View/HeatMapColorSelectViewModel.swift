//
//  HeatMapColorSelectViewModel.swift
//  History
//
//  Created by Donggyu Shin on 5/20/24.
//

import Foundation
import Combine
import Domain
import Common

final class HeatMapColorSelectViewModel: ObservableObject {
    @Published var selectedColor: Common.HeatMapColor
    private let getHeatMapColorUsecase: GetHeatMapColorUsecase
    private let postHeatMapColorUsecase: PostHeatMapColorUsecase
    private let subscribeHeatMapColorUsecase: SubscribeHeatMapColorUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        self.getHeatMapColorUsecase = .init(userRepository: userRepository)
        self.postHeatMapColorUsecase = .init(userRepository: userRepository)
        self.subscribeHeatMapColorUsecase = .init(userRepository: userRepository)
        self.selectedColor = .init(domain: getHeatMapColorUsecase.implement())
        bind()
    }
    
    func select(_ color: Common.HeatMapColor) {
        let color: Domain.HeatMapColor = color.domain
        postHeatMapColorUsecase.implement(color)
    }
    
    private func bind() {
        subscribeHeatMapColorUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .map({ $0 ?? .green })
            .map({ Common.HeatMapColor(domain: $0) })
            .assign(to: \.selectedColor, on: self)
            .store(in: &cancellables)
    }
}
