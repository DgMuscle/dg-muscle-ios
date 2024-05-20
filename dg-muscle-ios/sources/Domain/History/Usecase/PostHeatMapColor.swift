//
//  PostHeatMapColor.swift
//  Domain
//
//  Created by Donggyu Shin on 5/20/24.
//

import Foundation

public final class PostHeatMapColor {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func implement(_ heatMapColor: HeatMapColor) {
        try? userRepository.post(heatMapColor)
    }
}
