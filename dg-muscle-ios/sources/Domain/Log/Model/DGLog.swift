//
//  DGLog.swift
//  Domain
//
//  Created by 신동규 on 6/22/24.
//

import Foundation

public struct DGLog {
    public let id: String
    public let category: Category
    public let message: String
    public var resolved: Bool
    public let createdAt: Date
    public let creator: String
    
    public init(
        id: String,
        category: Category,
        message: String,
        resolved: Bool,
        createdAt: Date,
        creator: String
    ) {
        self.id = id
        self.category = category
        self.message = message
        self.resolved = resolved
        self.createdAt = createdAt
        self.creator = creator
    }
}

extension DGLog {
    public enum Category {
        case error
        case log
    }
}
