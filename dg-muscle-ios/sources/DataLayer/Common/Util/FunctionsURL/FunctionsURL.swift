//
//  FunctionsURL.swift
//  Data
//
//  Created by 신동규 on 5/15/24.
//

import Foundation

struct FunctionsURL {
    
    static private let suffix = "-kpjvgnqz6a-uc.a.run.app"
    static private let prefix = "https://"
    
    private init() { }
    
    static func history(_ type: History) -> String {
        "\(prefix)\(type.value)\(suffix)"
    }
    
    static func exercise(_ type: Exercise) -> String {
        "\(prefix)\(type.value)\(suffix)"
    }
    
    static func user(_ type: User) -> String {
        "\(prefix)\(type.value)\(suffix)"
    }
    
    static func friend(_ type: Friend) -> String {
        "\(prefix)\(type.value)\(suffix)"
    }
}
