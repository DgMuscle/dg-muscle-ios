//
//  HomeAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Domain
import Presentation
import Foundation

public struct HomeAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(HomeView.self) { (resolver, today: Date) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
            let heatMapRepository = resolver.resolve(HeatMapRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            let logRepository = resolver.resolve(LogRepository.self)!
            
            return HomeView(
                today: today,
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                heatMapRepository: heatMapRepository,
                userRepository: userRepository,
                logRepository: logRepository
            )
        }
    }
}
