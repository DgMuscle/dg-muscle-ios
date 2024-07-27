//
//  CoordinatorAssembly.swift
//  App
//
//  Created by 신동규 on 7/26/24.
//

import Foundation
import Swinject
import Domain
import Presentation
import SwiftUI

public struct CoordinatorAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(Coordinator.self) { (resolver, path: Binding<NavigationPath>) in
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let rapidRepository = resolver.resolve(RapidRepository.self)!
            
            return Coordinator(
                path: path,
                historyRepository: historyRepository,
                rapidRepository: rapidRepository
            )
        }
    }
}
