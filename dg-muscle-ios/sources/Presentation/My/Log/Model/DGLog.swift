//
//  DGLog.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import Domain
import Foundation
import SwiftUI

struct DGLog: Hashable {
    let id: String
    let category: Category
    let message: String
    let resolved: Bool
    let createdAt: Date
    let creator: String
    var user: User?
    var expanded: Bool = false
    
    init(domain: Domain.DGLog) {
        id = domain.id
        category = .init(domain: domain.category)
        message = domain.message
        resolved = domain.resolved
        createdAt = domain.createdAt
        creator = domain.creator
    }
    
    var domain: Domain.DGLog {
        .init(
            id: id,
            category: category.domain,
            message: message,
            resolved: resolved,
            createdAt: createdAt,
            creator: creator
        )
    }
}

extension DGLog {
    enum Category: String {
        case error
        case log
        
        init(domain: Domain.DGLog.Category) {
            switch domain {
            case .error:
                self = .error
            case .log:
                self = .log
            }
        }
        
        var domain: Domain.DGLog.Category {
            switch self {
            case .error:
                return .error
            case .log:
                return .log
            }
        }
        
        var color: Color {
            switch self {
            case .error:
                return .red
            case .log:
                return .yellow
            }
        }
    }
}

extension DGLog {
    struct User: Hashable {
        var displayName: String
        var photoURL: URL?
    }
}
