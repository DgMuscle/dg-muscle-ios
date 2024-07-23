//
//  RapidNavigation.swift
//  Presentation
//
//  Created by 신동규 on 7/21/24.
//

import Foundation

public struct RapidNavigation: Hashable {
    let name: Name
}

extension RapidNavigation {
    public enum Name {
        case rapidSearchTypeList
        case rapidSearchByBodyPart
        case rapidSearchByName
    }
}
