//
//  MakeStringFromURLUsecase.swift
//  Domain
//
//  Created by 신동규 on 8/3/24.
//

import Foundation

public final class MakeStringFromURLUsecase {
    public init() { }
    
    public func implement(url: URL) -> String {
        var result: String = url.absoluteString
        
        let http = "http://"
        let https = "https://"
        
        var prefix: String?
        
        if result.hasPrefix(http) {
            prefix = http
        }
        
        if result.hasPrefix(https) {
            prefix = https
        }
        
        if let prefix {
            result.removeFirst(prefix.count)
        }
        
        return result
    }
}
