//
//  Profile.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 10/8/23.
//

import Foundation

struct Profile: Codable {
    let id: String
    let photoURL: String?
    let displayName: String?
    var specs: [Spec]
    let updatedAt: CreatedAt?
}

extension Profile {
    struct Spec: Codable {
        let height: Double
        let weight: Double
        let createdAt: String
        
        var date: Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            return dateFormatter.date(from: createdAt) ?? Date()
        }
    }
}
