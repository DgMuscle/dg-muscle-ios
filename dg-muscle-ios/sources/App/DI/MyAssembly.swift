//
//  MyAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Domain
import Presentation
import My

public struct MyAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(MyProfileView.self) { resolver in
            
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return MyProfileView(userRepository: userRepository)
        }
        
        container.register(DeleteAccountConfirmView.self) { resolver in
            
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return DeleteAccountConfirmView(userRepository: userRepository)
        }
        
        container.register(LogsView.self) { resolver in
            
            let logRepository = resolver.resolve(LogRepository.self)!
            let friendRepository = resolver.resolve(FriendRepository.self)!
            
            return LogsView(
                logRepository: logRepository,
                friendRepository: friendRepository
            )
        }
    }
}