//
//  CoordinatorV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI
import Combine

final class CoordinatorV2: ObservableObject {
    static var instanceCount: Int = 0
    @Binding var path: NavigationPath
    
    lazy var exercise = ExerciseCoordinatorV2(path: $path)
    lazy var history = HistoryCoordinatorV2(path: $path)
    lazy var main = MainCoordinatorV2(path: $path)
    
    private let remoteCoordinator: RemoteCoordinator = RemoteCoordinator.shared
    private let getTodayHistoryUsecase: GetTodayHistoryUsecase =
        .init(historyRepository: HistoryRepositoryData.shared,
              today: Date())
    private var cancellables = Set<AnyCancellable>()
    init(path: Binding<NavigationPath>) {
        Self.instanceCount += 1
        self._path = path
        bind()
    }
    
    func pop(k: Int = 1) {
        if path.count >= k {
            path.removeLast(k)
        }
    }
    
    private func bind() {
        if Self.instanceCount == 2 {
            remoteCoordinator.$quickAction
                .receive(on: DispatchQueue.main)
                .compactMap({ $0 })
                .sink { [weak self] quickaction in
                    guard let self else { return }
                    let history: HistoryV
                    
                    if let domain = getTodayHistoryUsecase.implement() {
                        history = .init(from: domain)
                    } else {
                        history = .init()
                    }
                    
                    switch quickaction.type {
                    case .record:
                        self.history.historyForm(history)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
