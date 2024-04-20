//
//  Coordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import SwiftUI
import Combine
import Foundation

var coordinatorInstanceCount = 0

final class Coordinator: ObservableObject {
    
    @Binding var path: NavigationPath
    
    lazy var exercise = ExerciseCoordinator(path: $path)
    lazy var history = HistoryCoordinator(path: $path)
    lazy var main = MainCoordinator(path: $path)
    
    let remote = RemoteCoordinator.shared
    
    private let historyRepository = HistoryRepositoryV2Impl.shared
    private let healthRepository = HealthRepositoryLive.shared
    private let userRepository = UserRepositoryV2Live.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init(path: Binding<NavigationPath>) {
        coordinatorInstanceCount += 1
        self._path = path
        bind()
    }
    
    private func bind() {
        guard coordinatorInstanceCount == 2 else { return }
        remote.$quickAction
            .compactMap({ $0 })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                self?.receive(action: action)
            }
            .store(in: &cancellables)
    }
    
    private func receive(action: QuickAction) {
        switch action.type {
        case .record:
            let viewModel: HistoryViewModel = .init(historyRepository: historyRepository,
                                                    healthRepository: healthRepository, 
                                                    userRepository: userRepository)
            let history = viewModel.findTodayExerciseHistory()
            self.history.historyForm(history: history)
        }
    }
}
