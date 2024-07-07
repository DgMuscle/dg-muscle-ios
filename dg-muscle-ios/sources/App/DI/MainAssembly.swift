//
//  MainAssembly.swift
//  App
//
//  Created by 신동규 on 7/7/24.
//

import Swinject
import Domain
import Presentation
import Foundation
import Exercise
import History
import SwiftUI
import My
import Friend
import Auth

public struct MainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(Presentation.NavigationView.self) { (resolver, today: Date) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return Presentation.NavigationView(
                today: today,
                historyRepository: historyRepository,
                homeFactory: { today in resolver.resolve(HomeView.self, argument: today)! },
                exerciseListFactory: { resolver.resolve(ExerciseListView.self)! },
                postExerciseFactory: { exercise in resolver.resolve(PostExerciseView.self, argument: exercise)! },
                heatMapColorSelectFactory: { resolver.resolve(HeatMapColorSelectView.self)! },
                postHistoryFactory: { history in resolver.resolve(PostHistoryView.self, argument: history)! },
                manageRecordFactory: { historyForm, recordId in resolver.resolve(ManageRecordView.self, arguments: historyForm, recordId)! },
                manageRunFactory: { run in resolver.resolve(ManageRunView.self, argument: run)! },
                setDistanceFactory: { distance in resolver.resolve(SetDistanceView.self, argument: distance)! },
                setDurationFactory: { duration in resolver.resolve(SetDurationView.self, argument: duration)! },
                manageMemoFactory: { memo in resolver.resolve(ManageMemoView.self, argument: memo)! },
                dateToSelectHistoryFactory: { resolver.resolve(DateToSelectHistoryView.self)! },
                myProfileFactory: { resolver.resolve(MyProfileView.self)! },
                deleteAccountConfirmFactory: { resolver.resolve(DeleteAccountConfirmView.self)! },
                logsFactory: { resolver.resolve(LogsView.self)! },
                friendMainFactory: { anchor in resolver.resolve(FriendMainView.self, argument: anchor)! },
                friendHistoryFactory: { friendId, today in resolver.resolve(FriendHistoryView.self, arguments: friendId, today)! },
                historyDetailFactory: { friendId, historyId in resolver.resolve(HistoryDetailView.self, arguments: friendId, historyId)! }
            )
        }
        
        container.register(AuthenticationView.self) { (resolver, window: UIWindow?) in
            let appleAuthCoordinator = resolver.resolve(AppleAuthCoordinator.self, argument: window)!
            return AuthenticationView(appleAuthCoordinator: appleAuthCoordinator)
        }
    }
}
