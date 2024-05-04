//
//  HistoryNavigation.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation
import SwiftUI

struct HistoryNavigationV2: Identifiable, Hashable, Equatable {
    static func == (lhs: HistoryNavigationV2, rhs: HistoryNavigationV2) -> Bool {
        lhs.id == rhs.id
    }
    
    enum Name: String {
        case historyForm
        case recordForm
        case previousRecord
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var id: Int { name.hashValue }
    let name: Name
    
    var historyFormParameter: HistoryV? = nil
    
    var recordForForm: (Binding<RecordV>, Date)? = nil
    
    var previousRecord: (RecordV, Date)? = nil
    
    init(historyForm history: HistoryV) {
        name = .historyForm
        historyFormParameter = history
    }
    
    init(recordForForm: Binding<RecordV>, historyDateForForm: Date) {
        self.name = .recordForm
        self.recordForForm = (recordForForm, historyDateForForm)
    }
    
    init(previousRecord: (RecordV, Date)) {
        self.previousRecord = previousRecord
        self.name = .previousRecord
    }
}
