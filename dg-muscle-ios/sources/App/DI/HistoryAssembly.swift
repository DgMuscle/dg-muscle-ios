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

public struct HistoryNavigation: Assembly {
    public func assemble(container: Swinject.Container) {
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
                    coordinator?.historyFormStep2(historyForm: historyForm, recordId: recordId)
                } manageRun: { run in
                    coordinator?.manageRun(run: run)
                } manageMemo: { memo in
                    coordinator?.manageMemo(memo: memo)
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
    }
}
