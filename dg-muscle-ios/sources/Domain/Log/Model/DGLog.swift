//
//  DGLog.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public struct DGLog {
    let category: Category
    let message: String
    let resolved: Bool
    let createdAt: Date
    let creator: String
}

extension DGLog {
    public enum Category {
        case error
        case log
    }
}
