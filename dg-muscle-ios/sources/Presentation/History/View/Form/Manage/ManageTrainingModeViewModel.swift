//
//  ManageTrainingModeViewModel.swift
//  History
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Combine
import Domain
import Common

final class ManageTrainingModeViewModel: ObservableObject {
    
    @Published var mode: Common.TrainingMode?
    
    let color: Common.HeatMapColor
    
    let subscribeTrainingModeUsecase: SubscribeTrainingModeUsecase
    let postTraingModeUsecase: PostTraingModeUsecase
    let getHeatMapColorUsecase: GetHeatMapColorUsecase
    
    init(userRepository: UserRepository) {
        subscribeTrainingModeUsecase = .init(userRepository: userRepository)
        postTraingModeUsecase = .init(userRepository: userRepository)
        getHeatMapColorUsecase = .init(userRepository: userRepository)
        
        color = .init(domain: getHeatMapColorUsecase.implement())
        
        bind()
    }
    
    func updateMode(mode: Common.TrainingMode) {
        postTraingModeUsecase.implement(mode: mode.domain)
    }
    
    private func bind() {
        subscribeTrainingModeUsecase
            .implement()
            .receive(on: DispatchQueue.main)
            .map({ Common.TrainingMode(domain: $0) })
            .assign(to: &$mode)
    }
}
