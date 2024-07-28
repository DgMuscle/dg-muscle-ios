//
//  HistoryAssembly.swift
//  App
//
//  Created by 신동규 on 7/6/24.
//

import Swinject
import Domain
import History
import SwiftUI
import Presentation

public struct HistoryAssembly: Assembly {
    
    public func assemble(container: Swinject.Container) {
        
        container.register(HistoryListView.self) { (resolver, today: Date) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
            let heatMapRepository = resolver.resolve(HeatMapRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return HistoryListView(
                today: today,
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                heatMapRepository: heatMapRepository,
                userRepository: userRepository
            )
        }
        
        container.register(HeatMapColorSelectView.self) { resolver in
            let userRepository = resolver.resolve(UserRepository.self)!
            return HeatMapColorSelectView(userRepository: userRepository)
        }
        
        container.register(PostHistoryView.self) { (resolver, history: Domain.History?) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return PostHistoryView(
                historyRepository: historyRepository,
                exerciseRepository: exerciseRepository,
                userRepository: userRepository,
                history: history) { historyForm, recordId in
                    coordinator?.history.historyFormStep2(historyForm: historyForm, recordId: recordId)
                } manageRun: { run in
                    coordinator?.history.manageRun(run: run)
                } manageMemo: { memo in
                    coordinator?.history.manageMemo(memo: memo)
                } selectExerciseViewFactory: { tapExercise, add, close, run in
                    let exerciseRepository = resolver.resolve(ExerciseRepository.self)!
                    let userRepository = resolver.resolve(UserRepository.self)!
                    
                    return SelectExerciseView(
                        exerciseRepository: exerciseRepository,
                        userRepository: userRepository, 
                        historyRepository: historyRepository,
                        tapExercise: tapExercise,
                        add: add,
                        close: close,
                        run: run
                    )
                }
        }
        
        container.register(ManageRecordView.self) { (
            resolver,
            historyForm: Binding<HistoryForm>,
            recordId: String
        ) in
            let userRepository = resolver.resolve(UserRepository.self)!
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return ManageRecordView(
                historyForm: historyForm,
                recordId: recordId,
                userRepository: userRepository,
                historyRepository: historyRepository
            )
        }
        
        container.register(ManageRunView.self) { (resolver, run: Binding<RunPresentation>) in
            
            let userRepository = resolver.resolve(UserRepository.self)!
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return ManageRunView(
                run: run,
                userRepository: userRepository,
                historyRepository: historyRepository
            )
        }
        
        container.register(SetDistanceView.self) { (resolver, distance: Double) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return SetDistanceView(
                distance: distance,
                historyRepository: historyRepository
            )
        }
        
        container.register(SetDurationView.self) { (resolver, duration: Int) in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return SetDurationView(
                duration: duration,
                historyRepository: historyRepository
            )
        }
        
        container.register(ManageMemoView.self) { (_, memo: Binding<String>) in
            return ManageMemoView(memo: memo)
        }
        
        container.register(DateToSelectHistoryView.self) { resolver in
            
            let historyRepository = resolver.resolve(HistoryRepository.self)!
            
            return DateToSelectHistoryView(historyRepository: historyRepository)
        }
        
        container.register(ManageTrainingModeView.self) { resolver in
            
            let userRepository = resolver.resolve(UserRepository.self)!
            
            return ManageTrainingModeView(userRepository: userRepository)
        }
    }
}
