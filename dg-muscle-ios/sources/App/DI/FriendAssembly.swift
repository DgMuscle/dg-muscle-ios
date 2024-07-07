//
//  FriendAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Friend
import Domain
import Presentation
import Foundation

public struct FriendAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(FriendMainView.self) { (resolver, page: PageAnchorView.Page) in
            
            let friendRepository = resolver.resolve(FriendRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return FriendMainView(
                friendRepository: friendRepository,
                userRepository: userRepository,
                page: page
            )
        }
        
        container.register(FriendHistoryView.self) { (resolver, friendId: String, today: Date) in
            
            let friendRepository = resolver.resolve(FriendRepository.self)!
            
            return FriendHistoryView(
                friendRepository: friendRepository,
                friendId: friendId,
                today: today
            )
        }
        
        container.register(HistoryDetailView.self) { (resolver, friendId: String, historyId: String) in
            
            let friendRepository = resolver.resolve(FriendRepository.self)!
            
            return HistoryDetailView(
                friendRepository: friendRepository,
                friendId: friendId,
                historyId: historyId
            )
        }
    }
}
