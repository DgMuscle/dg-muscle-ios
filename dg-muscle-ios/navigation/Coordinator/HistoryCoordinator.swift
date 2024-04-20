//
//  HistoryCoordinator.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/20/24.
//

import SwiftUI
import Foundation

final class HistoryCoordinator {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func historyForm(history: ExerciseHistory?) {
        let navigation = HistoryNavigation(name: .historyForm,
                          historyForForm: history)
        path.append(navigation)
    }
    
    func recordForm(record: Binding<Record>,
                    date: Date,
                    startTimeInterval: TimeInterval) {
        let ingredient = HistoryNavigation.RecordFornIngredient(recordForForm: record,
                                               dateForRecordForm: date,
                                               startTimeInterval: startTimeInterval)
        let navigation = HistoryNavigation(name: .recordForm,
                                           recordFornIngredient: ingredient)
        
        path.append(navigation)
    }
    
    func monthlySection(historySection: ExerciseHistorySection) {
        let navigation = HistoryNavigation(name: .monthlySection,
                                           monthlySectionIngredient: historySection)
        path.append(navigation)
    }
}
