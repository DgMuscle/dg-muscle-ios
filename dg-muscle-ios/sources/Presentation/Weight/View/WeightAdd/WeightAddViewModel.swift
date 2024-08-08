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
    
    @Published var selectedDate: Date = .init()
    @Published var value: Double = 0
    
    let postWeightUsecase: PostWeightUsecase
    let getRecentWeightUsecase: GetRecentWeightUsecase
    
    init(weightRepository: WeightRepository) {
        postWeightUsecase = .init(weightRepository: weightRepository)
        getRecentWeightUsecase = .init(weightRepository: weightRepository)
        
        value = getRecentWeightUsecase.implement()?.value ?? 0 
    }
}
