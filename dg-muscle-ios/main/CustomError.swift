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
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .authentication:
            return "authentication error"
        case .invalidUrl:
            return "invalid url error"
        case .invalidResponse:
            return "invalid response error"
        case .unknown:
            return "unknown error"
        }
    }
}
