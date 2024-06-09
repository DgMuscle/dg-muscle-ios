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

public var coordinator: Coordinator?

public final class Coordinator {
    @Binding var path: NavigationPath
    
    private let historyRepository: HistoryRepository
    
    init(
        path: Binding<NavigationPath>,
        historyRepository: HistoryRepository
    ) {
        self._path = path
        self.historyRepository = historyRepository
    }
    
    public func pop(_ k: Int = 1) {
        path.removeLast(k)
    }
    
    public func profile() {
        path.append(MyNavigation(name: .profile))
    }
    
    public func historyFormStep1(historyId: String?) {
        /// If historyId is nil, find the today's history first.
        let history: History?
        
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
    
    public func addExercise(exercise: Exercise?) {
        path.append(ExerciseNavigation(name: .add(exercise)))
    }
    
    public func exerciseManage() {
        path.append(ExerciseNavigation(name: .manage))
    }
    
    public func heatMapColorSelectView() {
        path.append(HistoryNavigation(name: .heatMapColor))
    }
    
    public func friendMainView() {
        path.append(FriendNavigation(name: .main))
    }
}
