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
import Rapid
import Weight
import ExerciseTimer

public struct MainAssembly: Assembly {
    public func assemble(container: Swinject.Container) {
        container.register(Presentation.NavigationView.self) { (resolver, today: Date) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let exerciseTimerRepository = resolver.resolve(ExerciseTimerRepository.self)!
            
            return Presentation.NavigationView(
                today: today,
                historyRepository: historyRepository,
                exerciseTimerRepository: exerciseTimerRepository,
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
                deleteAccountConfirmFactory: { resolver.resolve(DeleteAccountConfirmView.self)! },
                logsFactory: { resolver.resolve(LogsView.self)! },
                friendMainFactory: { anchor in resolver.resolve(FriendMainView.self, argument: anchor)! },
                friendHistoryFactory: { friendId, today in resolver.resolve(FriendHistoryView.self, arguments: friendId, today)! },
                historyDetailFactory: { friendId, historyId in resolver.resolve(HistoryDetailView.self, arguments: friendId, historyId)! }, 
                manageTrainingModeFactory: { resolver.resolve(ManageTrainingModeView.self)! }, 
                rapidSearchTypeListFactory: { resolver.resolve(RapidSearchTypeListView.self)! },
                rapidSearchByBodyPartFactory: { resolver.resolve(RapidSearchByBodyPartView.self)! }, 
                rapidSearchByNameFactory: { resolver.resolve(RapidSearchByNameView.self)! },
                rapidExerciseDetailFactory: { exercise in resolver.resolve(RapidExerciseDetailView.self, argument: exercise)! },
                weightListFactory: { resolver.resolve(WeightListView.self)! },
                weightAddFactory: { resolver.resolve(WeightAddView.self)! },
                floatingTimerFactory: { timer in resolver.resolve(FloatingTimerView.self, argument: timer)! },
                coordinatorFactory: { path in resolver.resolve(Coordinator.self, argument: path)! }
            )
        }
        
        container.register(AuthenticationView.self) { (resolver, window: UIWindow?) in
            let appleAuthCoordinator = resolver.resolve(AppleAuthCoordinator.self, argument: window)!
            return AuthenticationView(appleAuthCoordinator: appleAuthCoordinator)
        }
        
        container.register(ContentViewModel.self) { (resolver) in
            let userRepository = resolver.resolve(UserRepository.self)!
            return ContentViewModel(userRepository: userRepository)
        }
    }
}
