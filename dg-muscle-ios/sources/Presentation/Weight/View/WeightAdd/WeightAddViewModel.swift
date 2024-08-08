//
//  WeightAddViewModel.swift
//  Weight
//
//  Created by Donggyu Shin on 8/8/24.
//

import Foundation
import Combine
import Domain
import Common

final class WeightAddViewModel: ObservableObject {
    
    @Published var selectedDate: Date = .init()
    @Published var value: Double = 0
    @Published var errorMessage: String?
    
    let postWeightUsecase: PostWeightUsecase
    let getRecentWeightUsecase: GetRecentWeightUsecase
    
    init(weightRepository: WeightRepository) {
        postWeightUsecase = .init(weightRepository: weightRepository)
        getRecentWeightUsecase = .init(weightRepository: weightRepository)
        
        value = getRecentWeightUsecase.implement()?.value ?? 0
    }
    
    func save() {
        guard value > 0 else {
            errorMessage = "Weight must be bigger than 0"
            return
        }
        
        postWeightUsecase.implement(weight: .init(value: value, unit: .kg, date: selectedDate))
        URLManager.shared.open(url: "dgmuscle://pop")
    }
}
