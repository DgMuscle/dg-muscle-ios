//
//  RapidNavigation.swift
//  Presentation
//
//  Created by 신동규 on 7/21/24.
//

import Foundation
import Domain

public struct RapidNavigation: Hashable {
    public static func == (lhs: RapidNavigation, rhs: RapidNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID().uuidString
    let name: Name
}

extension RapidNavigation {
    public enum Name {
        case rapidSearchTypeList
        case rapidSearchByBodyPart
        case rapidSearchByName
        case detail(Domain.RapidExerciseDomain)
    }
}
