//
//  WeightAddViewModel.swift
//  Weight
//
//  Created by Donggyu Shin on 8/8/24.
//

import Foundation
import Combine
import Domain

final class WeightAddViewModel: ObservableObject {
    let postWeightUsecase: PostWeightUsecase
    
    init(weightRepository: WeightRepository) {
        postWeightUsecase = .init(weightRepository: weightRepository)
    }
}
