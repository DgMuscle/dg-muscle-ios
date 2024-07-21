//
//  BodyPart.swift
//  Rapid
//
//  Created by 신동규 on 7/21/24.
//

import Foundation

struct BodyPart: Hashable {
    let name: String
    var selected: Bool
    
    init(bodyPart: RapidBodyPartPresentation) {
        name = bodyPart.rawValue
        selected = false
    }
    
    var bodyPart: RapidBodyPartPresentation? {
        return .init(rawValue: name)
    }
    
    mutating func toggle() {
        selected.toggle()
    }
}
