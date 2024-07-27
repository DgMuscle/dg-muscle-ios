//
//  DgLogMockData.swift
//  MockData
//
//  Created by 신동규 on 7/27/24.
//

import Domain

struct DgLogMockData: Codable {
    let id: String
    let category: Category
    let message: String
    let resolved: Bool
    let createdAt: CreatedAt
    let creator: String?
    
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

extension DgLogMockData {
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


