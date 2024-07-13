//
//  ManageTrainingModeViewModel.swift
//  History
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import Combine
import Domain

final class ManageTrainingModeViewModel: ObservableObject {
    
    let subscribeTrainingModeUsecase: SubscribeTrainingModeUsecase
    
    init(userRepository: UserRepository) {
        subscribeTrainingModeUsecase = .init(userRepository: userRepository)
    }
}
