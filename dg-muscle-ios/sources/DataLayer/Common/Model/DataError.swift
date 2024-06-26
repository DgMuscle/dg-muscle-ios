//
//  DataError.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

enum DataError: Error {
    case authentication
    case invalidUrl
    case invalidResponse
    case unknown
    case index
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authentication:
            return NSLocalizedString("Your authentication is not perfect. Please use it again after you log out.", comment: "authentication")
        case .invalidUrl:
            return NSLocalizedString("Sorry for inconvenience. Error code is 2", comment: "invalidUrl")
        case .invalidResponse:
            return NSLocalizedString("Sorry for inconvenience. Error code is 3", comment: "invalidResponse")
        case .unknown:
            return NSLocalizedString("Sorry for inconvenience. Error code is 4", comment: "unknown")
        case .index:
            return NSLocalizedString("There is index error.", comment: "index")
        }
    }
}
