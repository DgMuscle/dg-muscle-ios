//
//  CustomError.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import Foundation

enum CustomError: Error {
    case authentication
    case invalidUrl
    case invalidResponse
    case unknown
    case index
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .authentication:
            return "Authentication error"
        case .invalidUrl:
            return "Invalid url error"
        case .invalidResponse:
            return "Invalid response error"
        case .unknown:
            return "Unknown error"
        case .index:
            return "Can not find data index"
        }
    }
}
