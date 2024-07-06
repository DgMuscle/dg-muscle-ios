//
//  DataAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Domain
import DataLayer

public struct DataAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(HistoryRepository.self) { _ in
            return HistoryRepositoryImpl.shared
        }
        
        container.register(ExerciseRepository.self) { _ in
            return ExerciseRepositoryImpl.shared
        }
        
        container.register(HeatMapRepository.self) { _ in
            return HeatMapRepositoryImpl.shared
        }
        
        container.register(UserRepository.self) { _ in
            return UserRepositoryImpl.shared
        }
        
        container.register(FriendRepository.self) { _ in
            return FriendRepositoryImpl.shared
        }
        
        container.register(LogRepository.self) { _ in
            return LogRepositoryImpl.shared
        }
    }
}
