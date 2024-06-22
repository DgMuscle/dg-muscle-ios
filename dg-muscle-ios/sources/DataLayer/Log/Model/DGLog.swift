//
//  DGLog.swift
//  DataLayer
//
//  Created by 신동규 on 6/22/24.
//

import Domain

struct DGLog: Codable {
    let id: String
    let category: Category
    let message: String
    let resolved: Bool
    let createdAt: CreatedAt
    let creator: String
    
    init(domain: Domain.DGLog) {
        id = domain.id
        category = .init(domain: domain.category)
        message = domain.message
        resolved = domain.resolved
        createdAt = .init(_seconds: domain.createdAt.timeIntervalSince1970, _nanoseconds: 0)
        creator = domain.creator
    }
    
    var domain: Domain.DGLog {
        .init(
            id: id,
            category: category.domain,
            message: message,
            resolved: resolved,
            createdAt: .init(timeIntervalSince1970: createdAt._seconds),
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

