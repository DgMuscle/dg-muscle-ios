//
//  DGLog.swift
//  My
//
//  Created by 신동규 on 6/22/24.
//

import Domain
import Foundation

struct DGLog: Hashable {
    let id: String
    let category: Category
    let message: String
    let resolved: Bool
    let createdAt: Date
    let creator: String
    var user: User?
    
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
    enum Category: String, Codable {
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
    }
}

extension DGLog {
    struct User: Hashable {
        let displayName: String
        let photoURL: URL?
    }
}
