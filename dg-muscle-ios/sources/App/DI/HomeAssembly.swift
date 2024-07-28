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
import My
import History

public struct HomeAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(HomeView.self) { (resolver, today: Date) in
            
            return HomeView(
                today: today,
                historyListFactory: { today in resolver.resolve(HistoryListView.self, argument: today)! },
                myViewFactory: { presentProfileAction in resolver.resolve(MyView.self, argument: presentProfileAction)! },
                myProfileViewFactory: { resolver.resolve(MyProfileView.self)! }
            )
        }
    }
}
