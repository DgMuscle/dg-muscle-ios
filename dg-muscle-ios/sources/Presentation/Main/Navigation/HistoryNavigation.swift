//
//  HistoryNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/20/24.
//

import Foundation
import Domain
import History
import SwiftUI
import Common

public struct HistoryNavigation: Hashable {
    public static func == (lhs: HistoryNavigation, rhs: HistoryNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public init(name: Name) {
        self.name = name
    }
    
    let id: String = UUID().uuidString
    let name: Name
}

extension HistoryNavigation {
    public enum Name {
        case heatMapColor
        case historyFormStep1(Domain.History?)
        case historyFormStep2(historyForm: Binding<HistoryForm>, recordId: String)
        case manageRun(run: Binding<RunPresentation>)
    }
}
