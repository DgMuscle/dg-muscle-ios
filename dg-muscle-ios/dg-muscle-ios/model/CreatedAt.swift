//
//  CreatedAt.swift
//  dg-muscle-ios
//
//  Created by 신동규 on 2023/09/30.
//

struct CreatedAt: Codable {
    let seconds: Double
    let nanoseconds: Double
    
    enum CodingKeys : String, CodingKey {
        case seconds = "_seconds"
        case nanoseconds = "_nanoseconds"
    }
}
