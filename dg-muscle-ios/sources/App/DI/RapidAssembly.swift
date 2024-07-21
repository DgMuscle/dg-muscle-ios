//
//  RapidAssembly.swift
//  App
//
//  Created by 신동규 on 7/21/24.
//

import Swinject
import Domain
import Presentation
import Rapid

public struct RapidAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        
        container.register(RapidSearchTypeListView.self) { resolver in
            return RapidSearchTypeListView()
        }
    }
}
