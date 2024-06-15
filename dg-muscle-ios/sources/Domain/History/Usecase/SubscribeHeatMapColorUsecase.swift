//
//  SubscribeHeatMapColorUsecase.swift
//  Domain
//
//  Created by 신동규 on 5/19/24.
//

import Foundation
import Combine

public final class SubscribeHeatMapColorUsecase {
    @Published private var heatMapColor: HeatMapColor? = nil
    var temp: HeatMapColor? = nil
    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        bind()
    }
    
    public func implement() -> AnyPublisher<HeatMapColor?, Never> {
        $heatMapColor.eraseToAnyPublisher()
    }
    
    private func bind() {
        userRepository
            .user
            .map({ $0?.heatMapColor })
            .assign(to: \.heatMapColor, on: self)
            .store(in: &cancellables)
            
    }
}
