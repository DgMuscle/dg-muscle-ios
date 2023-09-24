//
//  CustomError.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/24.
//

import Foundation

enum CustomError: Error {
    case unknown
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return "unknown error"
        }
    }
}
