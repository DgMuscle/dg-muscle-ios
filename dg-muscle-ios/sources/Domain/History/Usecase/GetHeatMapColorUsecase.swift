//
//  GetHeatMapColorUsecase.swift
//  Domain
//
//  Created by Donggyu Shin on 5/20/24.
//

import Foundation

public final class GetHeatMapColorUsecase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement() -> HeatMapColor {
        userRepository.get()?.heatMapColor ?? .green
    }
}
