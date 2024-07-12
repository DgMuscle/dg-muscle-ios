//
//  Coordinator.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation
import SwiftUI
import Domain
import History
import Friend
import Common

public var coordinator: Coordinator?

// TODO: Coordinator 나누기

public final class Coordinator {
    @Binding var path: NavigationPath
    
    private let historyRepository: HistoryRepository
    
    public let exercise: ExerciseCoordinator
    public let friend: FriendCoordinator
    
    init(
        path: Binding<NavigationPath>,
        historyRepository: HistoryRepository
    ) {
        self._path = path
        self.historyRepository = historyRepository
        self.exercise = .init(path: path)
        self.friend = .init(path: path)
    }
    
    public func pop(_ k: Int = 1) {
        path.removeLast(k)
    }
    
    public func historyFormStep1(historyId: String?) {
        /// If historyId is nil, find the today's history first.
        let history: Domain.History?
        
        if let historyId {
            history = historyRepository.get(historyId: historyId)
        } else {
            let histories = historyRepository.get()
            history = histories.first(where: { Calendar.current.isDate(Date(), inSameDayAs: $0.date) })
        }
        
        path.append(HistoryNavigation(name: .historyFormStep1(history)))
    }
    
    public func historyFormStep2(historyForm: Binding<HistoryForm>, recordId: String) {
        path.append(
            HistoryNavigation(
                name: .historyFormStep2(
                    historyForm: historyForm,
                    recordId: recordId
                )
            )
        )
    }
    
    public func heatMapColorSelectView() {
        path.append(HistoryNavigation(name: .heatMapColor))
    }
    
    public func manageRun(run: Binding<RunPresentation>) {
        path.append(HistoryNavigation(name: .manageRun(run: run)))
    }
    
    public func setDistance(distance: Double) {
        path.append(HistoryNavigation(name: .setDistance(distance)))
    }
    
    public func setDuration(duration: Int) {
        path.append(HistoryNavigation(name: .setDuration(duration)))
    }
    
    public func manageMemo(memo: Binding<String>) {
        path.append(HistoryNavigation(name: .manageMemo(memo)))
    }
    
    public func dateToSelectHistory() {
        path.append(HistoryNavigation(name: .dateToSelectHistory))
    }
    
    public func profile() {
        path.append(MyNavigation(name: .profile))
    }
    
    public func deleteAccountConfirm() {
        path.append(MyNavigation(name: .deleteAccountConfirm))
    }
    
    public func logs() {
        path.append(MyNavigation(name: .logs))
    }
}
