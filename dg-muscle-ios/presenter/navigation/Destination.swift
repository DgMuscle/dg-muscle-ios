//
//  Destination.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 5/4/24.
//

import Foundation

struct Destination {
    let value: Value
    init?(value: String) {
        guard let value = Value(rawValue: value) else { return nil }
        self.value = value
    }
}

extension Destination {
    enum Value: String {
        case friendRequest = "friend_request"
    }
}
