//
//  MyNavigation.swift
//  Presentation
//
//  Created by 신동규 on 5/25/24.
//

import Foundation

public struct MyNavigation: Hashable {
    let name: Name
}

extension MyNavigation {
    public enum Name {
        case profile
        case deleteAccountConfirm
    }
}
