//
//  HistoryCoordinator.swift
//  Presentation
//
//  Created by 신동규 on 7/13/24.
//

import Foundation
import SwiftUI
import History
import Domain

public final class HistoryCoordinator {
    @Binding var path: NavigationPath
    
    let historyRepository: HistoryRepository
    
    init(
        path: Binding<NavigationPath>,
        historyRepository: HistoryRepository
    ) {
        self._path = path
        self.historyRepository = historyRepository
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
}
