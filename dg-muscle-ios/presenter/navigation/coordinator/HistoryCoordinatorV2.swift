//
//  HistoryCoordinatorV2.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 4/28/24.
//

import Foundation
import SwiftUI

final class HistoryCoordinatorV2 {
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func historyForm(_ history: HistoryV) {
        path.append(HistoryNavigationV2(historyForm: history))
    }
    
    func recordForm(record: Binding<RecordV>, historyDateForForm: Date) {
        path.append(HistoryNavigationV2(recordForForm: record, historyDateForForm: historyDateForForm))
    }
}
