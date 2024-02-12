//
//  QuickAction.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2/12/24.
//

import Foundation

struct QuickAction {
    let type: Actiontype
    let title: String
    let subTitle: String?
    
    init(type: Actiontype) {
        self.type = type
        switch type {
        case .record:
            title = "Record"
            subTitle = "record today exercise"
        }
    }
}

extension QuickAction {
    enum Actiontype: String {
        case record = "com.dgmuscle.record"
        
    }
}
